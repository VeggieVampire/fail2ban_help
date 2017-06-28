#!/bin/bash
#  *****Z
#
# fail2ban status checking script
#
# Author Nick Farrow
#
# Initial Release: 0



log='/var/log/fail2ban.log'

# Simple Reports
        Simple_ReportZ()
        {
		echo "Generating Simple Reports"
	awk '($(NF-1) = /Ban/){print $NF}' $log | sort | uniq -c | sort -n
		printf "\n"
        }

#problematic subnets
        problematic_subnetsZ()
        {
		echo "problematic subnets Reports"
		echo "ctrl+c to exit"
	zgrep -h "Ban " $log* | awk '{print $NF}' | awk -F\. '{print $1"."$2"."}' | sort | uniq -c  | sort -n | tail
		printf "\n"
        }

#access_exploits
        access_exploitZ()
        {
		echo "This shows us which services each IP address has been trying to access_exploit"
	grep "Ban " $log | awk -F[\ \:] '{print $10,$8}' | sort | uniq -c | sort -n
		printf "\n"
        }

#todays activity
        todays_activityZ()
        {
		echo "This generate a summary of the days activity"
	grep "Ban " $log | grep `date +%Y-%m-%d` | awk '{print $NF}' | sort | awk '{print $1,"("$1")"}' | nslookup | uniq -c | sort -n
		printf "\n"
        }
		
		
#Unblock An IP Address
        UnblockZ()
        {
	echo "What IP Address would you like to Unblock?"
read hoststring
	sudo iptables -D INPUT -s $hoststring -j DROP
		printf "\n"
        }
		
#block An IP Address
        BlockZ()
        {
	echo "What IP Address would you like to block?"
read hoststring
	sudo iptables -A INPUT -s $hoststring -j DROP
		printf "\n"
        }
		
# MAIN BODY OF SCRIPT
#
# Present the menu selection to the user

        echo " What would you like to do?"
        PS3="Please select a numeric option:  "

        select option in Simple_Reports Problematic_Subnets Access_Exploits Todays_Activity UnBlock_IP Block_IP Exit

        do 
                case "$option"
                        in
                                Simple_Reports    		)  Simple_ReportZ;;
								Problematic_Subnets    	)  problematic_subnetsZ;;
								Access_Exploits    		)  access_exploitZ;;
								Todays_Activity    		)  todays_activityZ;;
								UnBlock_IP    			)  UnblockZ;;
								Block_IP    			)  BlockZ;;
                                Exit         			)  exit 0;;
                                *            			)  echo "Invalid selection ! ";;
                       esac
       done
