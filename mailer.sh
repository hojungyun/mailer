#!/bin/bash

#
# Script to send email with attachment by mutt
#
# Author: Hojung Yun (hojung_yun@yahoo.co.kr)
# Date: 2016.01.22
#

usage="Usage: $(basename $0) <mail_server> <attachment_dir> -- script to send email with attachment to SMTP server"
if [ $# -ne 2 ] ; then
    echo "$usage"
    exit 1
fi

senders=(
  john@attacker.com
  kim@attacker.com
  alison@attacker.com
  angel@attacker.com
  evan@attacker.com
  hunter@attacker.com
  kevin@attacker.com
  luke@attacker.com
  maria@attacker.com
  tyler@attacker.com
)
recipients=(
  john@victim.com
  kim@victim.com
  alison@victim.com
  angel@victim.com
  evan@victim.com
  hunter@victim.com
  kevin@victim.com
  luke@victim.com
  maria@victim.com
  tyler@victim.com
)
interval_min=5 #<-- random interval mix time in sec
interval_max=10 #<-- random interval max time in sec
interval_difference=$((interval_max - interval_min))
interval=0

while true
do
  for malware in `ls $2`
  do
    senderRandomIndex=$((RANDOM%${#senders[@]})) #<--- ${#senders[@]} is length of 'senders' array
    recipientRandomIndex=$((RANDOM%${#recipients[@]})) #<--- ${#recipients[@]} is length 'recipients' array

    # send an email with malware sample
    echo "Sending email to $1 with ${malware} (${senders[$senderRandomIndex]} -> ${recipients[$recipientRandomIndex]})"
    echo "this is the test email with malware sample" | mutt -s "test email" -e "set realname=${senders[$senderRandomIndex]} from=${senders[$senderRandomIndex]} smtp_url=smtp://$1:25" -a "$2/${malware}" -- ${recipients[$recipientRandomIndex]}

	# generate random interval
    interval=$(( (RANDOM % ((interval_difference+1)) ) + interval_min )) #<--- generate number between mix and max
    echo "Next email will be sent in $interval secs"
	
	# sleep before sending email
    sleep $interval

  done
done
