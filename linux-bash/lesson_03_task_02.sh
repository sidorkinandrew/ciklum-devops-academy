#!/bin/bash
#  Make another script that will run on premise and count successful / unsuccessful login attempts per user.

LOG=/var/log/auth.log
DEBUG=false


get_logins_from_log(){
  echo  $(cat $LOG | grep -E -i -a "sshd|login" | grep -i -a " "$1" " | grep -i -a ": "$2 | wc -l)
  return
}


USERS=$(cat /var/log/auth.log | grep -E -a -i "login|sshd" | grep -E -a -i " accepted| failed" | grep -Po -a  "(?<=for )(.*)(?= from)" | sort | uniq)

USERS=$(echo $USERS | sed -e "s/invalid user//g")


for i in $USERS; do
  if [ "$DEBUG" = true ]; then
    echo "============================================"
    echo "USERNAME: $i has the following $(get_logins_from_log $i failed) failed entries in the $LOG"
    cat $LOG | grep -E -i -a "sshd|login" | grep -i -a " "$i" " | grep -i -a ": failed"
    echo "============================================"
    echo "USERNAME: $i has the following $(get_logins_from_log $i accepted) successful entries in the $LOG"
    cat $LOG | grep -E -i -a "sshd|login" | grep -i -a " "$i" " | grep -i -a ": accepted"
  else
    echo "USERNAME: $i has " $(get_logins_from_log $i failed) "/"  $(get_logins_from_log $i accepted) "failed/successful logins ";
  fi
done
