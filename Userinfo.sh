#!/bin/bash

user_cmd=`who | grep pts/0 | awk '{print $1}'`
terminal_cmd=`who | grep pts/0 | awk '{print $2}'`
data_cmd=`who | grep pts/0 | awk '{print $3,$4}'`
ip_cmd=`who | grep pts/0 | awk '{print $5}' | cut -c 2- | cut -c -12`

echo Usuário: $user_cmd
echo Terminal: $terminal_cmd
echo Data: $data_cmd
echo IP: $ip_cmd
