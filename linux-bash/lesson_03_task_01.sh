#!/bin/bash
#  - Make a script that will run every minute and check logs for successful or unsuccessful attempts for SSH login.


# cat /var/spool/cron/crontabs
# * * * * * ~/login_checker.sh >> /var/log/log_checker.log 2>&1

LOG=/var/log/auth.log

get_sshd_from_auth(){
  echo  $(cat $LOG | grep -i -a "sshd" | grep -i ": "$1 | wc -l)
  return
}

echo "host: $HOSTNAME ~ `date +%Y-%m-%d_%H-%M-%S-%3N`: The number of failed logins: " $(get_sshd_from_auth failed) " / successful logins: " $(get_sshd_from_auth accepted)