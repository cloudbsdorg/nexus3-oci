#!/usr/bin/env zsh

ifconfig eth0

cd /usr/local/nexus/bin
APP_JAVA_HOME=/usr/local/openjdk17 ./nexus run