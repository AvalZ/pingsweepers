#!/bin/bash

if [[ $# -eq 0 ]]
then
   echo "A simple Bash ping scanner."
   echo "Usage: $0 ip_range"
   exit 0
fi

is_up() {
  ping -c 1 $1 > /dev/null
  [ $? -eq 0 ] && echo "$1 is up"
}

for ip in 192.168.1.{1..255}
do
  is_up $ip & disown
done
