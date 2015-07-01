#!/bin/bash 
if [ $# -eq 0 ]
  then
    echo 'No Cassandra base dir indicated, assuming /var/lib/cassandra!'
    CASSANDRA_CONF_BASE='/etc/cassandra/conf'
  else
    CASSANDRA_CONF_BASE=$1
  fi
# JMX PORT
grep "JMX_PORT" $CASSANDRA_CONF_BASE/cassandra-env.sh | grep -v "#"
# Garbage Collecting
grep "PrintGCDetails" $CASSANDRA_CONF_BASE/cassandra-env.sh | grep -v "#"
# GC Log File
grep "Xloggc" $CASSANDRA_CONF_BASE/cassandra-env.sh | grep -v "#"
grep "MAX_HEAP_SIZE" $CASSANDRA_CONF_BASE/cassandra-env.sh | grep -v "#"
grep "HEAP_NEWSIZE" $CASSANDRA_CONF_BASE/cassandra-env.sh | grep -v "#"