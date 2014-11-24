#!/bin/bash
#
# The script for managing lighttpd process
# 

LIGHTTPD=$LIGHTTPD_BIN
CONF=$LIGHTTPD_CONF
PID_FILE="/var/run/lighttpd.pid"
PID=0

if [ -z $LIGHTTPD_BIN ]; then
    LIGHTTPD="/usr/local/sbin/lighttpd"
fi
if [ -z $CONF ]; then 
    CONF="/root/conf/lighttpd.conf"
fi

start (){

    if [ -f $PID_FILE ]; then
	echo "pid file exsits"
	return 1
    else
	echo $LIGHTTPD" "$CONF
	$LIGHTTPD -f $CONF -D&
	echo $! >> $PID_FILE
    fi
}

stop () {
    if [ -f $PID_FILE ]; then
	PID=`cat $PID_FILE`
	rm $PID_FILE
	`kill $PID`
	return 0
    else
	echo "pid file doesn't exsits. process has already stopped"
	return 1
    fi
}

status() {
    if [ -f $PID_FILE ]; then
	PID=`cat $PID_FILE`
	 echo "lighttpd is running with $PID"
         return 0
    else
	echo "lighttpd is not running"
    fi
}

# This is a bad workaround. need to get pid when lighttpd is executed
#PID=`ps aux | grep $LIGHTTPD | grep -v grep | awk '{print $2}'`
case "$1" in
"start" ) start ;;
"stop"  ) stop ;;
"restart" ) stop;start;;
"status"  ) status;;
* ) echo "no arg. need {start | stop | status}";;
esac
