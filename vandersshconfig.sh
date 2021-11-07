#!/bin/bash
#Date: oct/01/2021
#Author: Vander Nunes
#Role: Create, change and remove users and groups
#Version: 1.0.0

clear
echo "What it will be the authentication method?"
echo ----------------------------------
echo "1) Password Authentication"
echo "2) Public Key Authentication"
echo "3) End"
echo ----------------------------------
echo -n "Write an option: "
read option

SSHCONFIG=/etc/ssh/sshd_config

if [ -z $option ]; then
echo "You have to choice an option!"
	"/bin/vandersshconfig"

	elif [ $option = "1" ]; then
	cat /tmp/pwdkey.txt >> $SSHCONFIG
		echo -n "Type the user name to define the password: "
		read nameuser
        passwd $nameuser

	systemctl restart sshd

	elif [ $option = "2" ]; then
	cat /tmp/pwdkey.txt >> $SSHCONFIG
	echo "Type the user name to define the public key: "
	read nameuser
	echo "Paste the customer key: "
	read customerkey
	mkdir -p /home/$nameuser/.ssh
	echo $customerkey > /home/$nameuser/.ssh/authorized_keys
	echo "Press any key to end"
	read
	systemctl restart sshd
               exit

	elif [ $option = "3" ]; then
		exit
else
		echo "Type a valid option!"
	"/bin/vandersshconfig"
fi
