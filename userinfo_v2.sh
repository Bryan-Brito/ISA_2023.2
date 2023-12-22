#!/bin/bash

IFS=$'\n'

reg=1
for result in `who | grep -v tty1`
do
	user_cmd=`echo $result | awk '{print $1}'`
	terminal_cmd=`echo $result | awk '{print $2}'`
	data_cmd=`echo $result | awk '{print $3,$4}'`
	# exemplo com o tr
	#ip_cmd=`echo $result | awk '{print $5}' | tr -d "()"`
	# exemplo com o sed
	ip_cmd=`echo $result | awk '{print $5}' | sed 's/(//; s/)//'`

	echo "Registro: $reg"
	echo Usuário: $user_cmd
	echo Terminal: $terminal_cmd
	echo Data: $data_cmd
	echo IP: $ip_cmd
	echo ""
	let reg++
done
