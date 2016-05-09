#!/bin/bash
set -o errexit -o pipefail

declare -a java_args
declare -a app_args
FRAMEWORK_HOME=`dirname $0`/..
CONF_FILE=/etc/default/marathon


export MESOS_NATIVE_JAVA_LIBRARY=/usr/lib/libmesos.so
export MESOS_NATIVE_LIBRARY=$MESOS_NATIVE_JAVA_LIBRARY

#prepare authentication secret file if the secret is passed in via env
if [[ -n "$MARATHON_MESOS_AUTHENTICATION_SECRET" ]]; then
  secret_path=/secret_from_env
  echo "Converting auth secret to file"
  echo -n "$MARATHON_MESOS_AUTHENTICATION_SECRET" > $secret_path
  chmod 600 $secret_path
  unset MARATHON_MESOS_AUTHENTICATION_SECRET
  export MARATHON_MESOS_AUTHENTICATION_SECRET_FILE=$secret_path
fi

# Read environment variables from config file
set -o allexport
[[ ! -f "$CONF_FILE" ]] || . "$CONF_FILE"
set +o allexport

addJava() { java_args=( "${java_args[@]}" "$1" ); }
addApplication() { app_args=( "${app_args[@]}" "$1" ); }
addDebugger() {
  addJava "-Xdebug"
  addJava "-Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=$1"
}
die() {
  echo "Aborting: $@"
  exit 1
}
require_arg() {
  local type="$1"
  local opt="$2"
  local arg="$3"
  if [[ -z "$arg" ]] || [[ "${arg:0:1}" == "-" ]]; then
    die "$opt requires <$type> argument"
  fi
}

# Filter out MARATHON_APP* env variables. All MARATHON_XXX=yyy variables are interpreted as -xxx yyy application parameter
for env_op in `env | grep -v ^MARATHON_APP | grep ^MARATHON_ | awk '{gsub(/MARATHON_/,""); gsub(/=/," "); printf("%s%s ", "--", tolower($1)); for(i=2;i<=NF;i++){printf("%s ", $i)}}'`; do
  addApplication "$env_op"
done

while [[ $# -gt 0 ]]; do
  case "$1" in
    -D*) addJava "$1" && shift ;;
    --jvm-debug) require_arg port "$1" "$2"; addDebugger "$2" && shift 2;;
    *) addApplication "$1" && shift ;;
  esac
done

if [ -n ${JVM_OPTS+x} ]
then
  for arg in ${JVM_OPTS[@]}
  do
    addJava "$arg"
  done
fi

if [ -n ${JAVA_OPTS+x} ]
then
  for arg in ${JAVA_OPTS[@]}
  do
    addJava "$arg"
  done
fi

# Start Marathon
marathon_jar=/usr/bin/marathon
echo "${java_args[@]}" -jar "$marathon_jar" "${app_args[@]}"
exec java "${java_args[@]}" -jar "$marathon_jar" "${app_args[@]}"