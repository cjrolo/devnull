#!/bin/bash 
# You can provide the location of the host file in the first argument
if [ $# -eq 0 ]
  then
    HOSTFILE='../conf/hosts.txt'
  else
    HOSTFILE=$1
  fi
for HOST in `cat $HOSTFILE`
do
  # For now, port must always be defined, even if it is 22
  PORT=`echo $HOST | cut -f2 -d:`
  SERVER=`echo $HOST | cut -f2 -d@ | cut -f1 -d:`
  HOSTNAME=`echo $HOST | cut -f1 -d:`
  scp -P $PORT $HOSTNAME:/etc/cassandra/conf/cassandra.yaml $SERVER-cassandra.yaml
  scp -P $PORT $HOSTNAME:/etc/cassandra/conf/cassandra-env.sh $SERVER-cassandra-env.sh
done