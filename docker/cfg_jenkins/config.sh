#!/bin/sh

PARAMFILE=/secure.groovy

if [ -z "$ADMIN_PASSWORD" ]
then
   echo >&2 'error: jenkins is uninitialized and password option is not specified'
   echo >&2 '  You need to specify one of ADMIN_PASSWORD'
   exit 1
fi

ADMIN_USER=${ADMIN_USER:-admin}
JENKINS_HOST=${JENKINS_HOST:-jenkins:8080}

sed -i  "s/__ADMIN_USER__/$ADMIN_USER/
         s/__ADMIN_PASSWORD__/$ADMIN_PASSWORD/" ${PARAMFILE}

echo "Waiting for jenkins http server to be ready"
while ! curl -s http://$JENKINS_HOST > /dev/null
do
  date
  sleep 5
done

echo "Waiting for jenkins to be configured"
while curl -s http://$JENKINS_HOST | grep -q "Please wait while Jenkins is getting ready"
do
  date
  sleep 5
done

curl -d "script=$(cat $PARAMFILE)" http://$JENKINS_HOST/scriptText

