#!/bin/bash
# TESTED ON CENTOS 6, 7
# Cassandra install script 
yum -y install epel-release
yum -y update
yum -y install ntp ntp-data ntp-doc wget vim curl htop
# Create Cassandra user
PASSWD=tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1
# Store the password somewhere
echo PASSWD > deleteme.txt
adduser cassandra
echo "cassandra:$PASSWD" | chpasswd
# Installing Java
cd /opt/
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.tar.gz"
tar xzf jdk-8u45-linux-x64.tar.gz
cd /opt/jdk1.8.0_45/
alternatives --install /usr/bin/java java /opt/jdk1.8.0_45/bin/java 1
# Set OS Limits
echo "cassandra soft memlock unlimited
cassandra hard memlock unlimited
cassandra – nofile 100000
cassandra – nproc 32768
cassandra – as unlimited" > /etc/security/limits.d/cassandra.conf
echo "vm.max_map_count = 131072" > /etc/sysctl.d/cassandra.conf
# SSD Optimizations
echo deadline > /sys/block/sda/queue/scheduler
echo 0 > /sys/class/block/sda/queue/rotational
echo 8 > /sys/class/block/sda/queue/read_ahead_kb
# Installing Cassandra
#wget http://ftp.nluug.nl/internet/apache/cassandra/2.1.7/apache-cassandra-2.1.7-bin.tar.gz
echo "[datastax] 
name = DataStax Repo for Apache Cassandra
baseurl = http://rpm.datastax.com/community
enabled = 1
gpgcheck = 0" > /etc/yum.repos.d/datastax_community.repo
yum install -y dsc21
yum install -y cassandra-tools
# Cleanup
yum -y clean all