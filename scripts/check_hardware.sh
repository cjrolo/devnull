#!/bin/bash 
if [ $# -eq 0 ]
  then
    echo 'No Cassandra base dir indicated, assuming /var/lib/cassandra!'
    CASSANDRA_BASE='/var/lib/cassandra'
  else
    CASSANDRA_BASE=$1
  fi
# Initialize the file
echo '' > hardware.txt
# Put a date on it
echo `date` > hardware.txt
# Get the rest of the Information
echo '### Memory ###' >> hardware.txt
cat /proc/meminfo >> hardware.txt
echo '### CPU ###' >> hardware.txt
cat /proc/cpuinfo >> hardware.txt
echo '### HARDDRIVES ###' >> hardware.txt
echo '== RAID' >> hardware.txt
lsblk | grep -i raid >> hardware.txt
echo '== Drives' >> hardware.txt
for DRIVE in $(lsblk | grep disk | cut -d' ' -f 1 )
  do
    test `cat /sys/block/$DRIVE/queue/rotational` -eq 0 && echo "$DRIVE: SSD" >> hardware.txt || echo "$DRIVE: Spinning" >> hardware.txt
  done
echo '== Cassandra Drives' >> hardware.txt
df -P $CASSANDRA_BASE/data | tail -1 | cut -d' ' -f 1 
df -P $CASSANDRA_BASE/commitlog | tail -1 | cut -d' ' -f 1 
# SAR has a file of its own...
sar -d > sar_data.txt
# What would be smart? Picking up the Cassandra drives, locating the block device, then sar and grep for that only.


