#!/bin/bash 
if [ $# -eq 0 ]
  then
    echo 'No Cassandra user indicated, assuming root!'
    CASSANDRA_USER='root'
  else
    CASSANDRA_BASE=$1
  fi
# Initialize the file
echo '' > os.txt
# Put a date on it
echo `date` > os.txt
echo '### OS ###' >> os.txt
cat /proc/version >> os.txt
echo '### LIMITS ###' >> os.txt
ulimit -a >> os.txt
# Test if active
echo "$CASSANDRA_USER Limits:" 
runuser -l $CASSANDRA_USER -c 'ulimit -Sa' >> os.txt
echo '### SWAP ###' >> os.txt
cat /proc/sys/vm/swappiness >> os.txt
echo '### JAVA ###' >> os.txt
java -version >> os.txt
ps aux | grep -i jna | grep -v 'grep' > /dev/null
test `echo $?` -eq 0 && echo "JNA: Yes" >> os.txt || echo "JNA: No" >> os.txt

