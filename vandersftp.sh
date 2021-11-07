#!/bin/bash
#Date: oct/01/2021
#Author: Vander Nunes
#Role: Create, change and remove users and groups
#Version: 1.0.0

clear
echo "Users and Groups for SFTP"
echo ----------------------------------
echo "1) Create user"
echo "2) Delete user"
echo "3) End"
echo ----------------------------------
echo -n "Write an option: "
read option

OUT1=/tmp/pwdkey.txt
OUT2=/tmp/pubkey.txt

rm -rf /tmp/pwdkey.txt &&
rm -rf /tmp/pubkey.txt &&

if [ -z $option ]; then
echo "You have to choice an option!"
	"/bin/vandersftp"

	elif [ $option = "1" ]; then
		echo -n "Type the user name that should be created: "
		read nameuser
		useradd -m "$nameuser" -g sftp -s /sbin/nologin
		echo "User added."
		mkdir -p /var/sftp/$nameuser/uploads
		echo "SFTP folder created."
		chown root:root /var/sftp/$nameuser
		chown $nameuser:sftp /var/sftp/$nameuser/uploads
		echo "Permissions granted"
		echo "Press enter to continue..."

	echo "Match User $nameuser" >> $OUT1
	echo    "ForceCommand internal-sftp" >> $OUT1
	echo    "PasswordAuthentication yes" >> $OUT1
	echo    "ChrootDirectory /var/sftp/$nameuser" >> $OUT1
	echo    "PermitTTY no" >> $OUT1
	echo    "AllowAgentForwarding no" >> $OUT1
	echo    "AllowTcpForwarding no" >> $OUT1
	echo    "X11Forwarding no" >> $OUT1

	echo "Match User $nameuser" >> $OUT2
	echo    "ForceCommand internal-sftp" >> $OUT2
	echo    "PasswordAuthentication no" >> $OUT2
	echo    "ChrootDirectory /var/sftp/$nameuser" >> $OUT2
	echo    "PermitTTY no" >> $OUT2
	echo    "AllowAgentForwarding no" >> $OUT2
	echo    "AllowTcpForwarding no" >> $OUT2
	echo    "X11Forwarding no" >> $OUT2

		read
		"/bin/vandersshconfig"

	elif [ $option = "2" ]; then
		echo -n "Type the user name that should be deleted: "
		read nameuser
		deluser "$nameuser"
		echo "User deleted."
		echo "Press any key to exit"
		read
		exit

	elif [ $option = "3" ]; then
		exit
else
		echo "Type a valid option!"
	"/bin/vandersftp"
fi
