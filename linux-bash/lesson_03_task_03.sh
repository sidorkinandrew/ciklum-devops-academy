#!/bin/bash
# Count how many times each user assumed root privileges

grep -a -i "sudo:  " /var/log/auth.log | cut -d: -f4 | sort | uniq -c