# FILE #1 /usr/bin/send-w-telegu - send messages to telegram
# cat /usr/bin/send-w-telegu

#!/bin/bash
# On every login attempt or on assume root privileges post a message in Telegram


GROUP_ID=-1001597935904
BOT_TOKEN="388831284:AAFlFvW-raZ_2euif0m_8zo-bOlCY5mQrGI"

curl -s --data "text=$1" --data "chat_id=$GROUP_ID" 'https://api.telegram.org/bot'$BOT_TOKEN'/sendMessage' > /dev/null



# FILE #2 /etc/profile.d/telega-notify.sh - send notification on every login
# cat /etc/profile.d/telega-notify.sh

#!/bin/bash


login_date="$(date +%Y-%m-%d_%H-%M-%S-%3N)"
login_name="$(whoami)"

msg="Login "$login_name" on "$login_date

send-w-telegu "$msg"



# FILE #3 - /root/.bashrc - appended the following lines to send notification to telegram when sudo su OR sudo -i is executed
# cat /root/.bashrc

if [ -n "${BASH_VERSION}" ]; then
    trap "caller >/dev/null || \
printf '%s\\n' \"\$(date '+%Y-%m-%dT%H:%M:%S%z')\
 \$(tty) \${BASH_COMMAND}\" 2>/dev/null >>~/.command_log" DEBUG
fi

send-w-telegu "root permission was assumed"
