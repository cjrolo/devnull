#!/bin/bash
# Change Keytool path if script fails!
keytool -genkey -alias $1 -keyalg RSA -keystore .keystore
keytool -export -alias $1 -file $1.cer -keystore .keystore
keytool -import -v -trustcacerts -alias cassandra -file cassandra.cer -keystore .truststore
