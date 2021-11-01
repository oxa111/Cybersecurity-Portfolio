#!/bin/bash
mkdir ~/boo 2> /dev/null
echo -e "\nThese are the executable files" > ~/boo/execs.txt
sudo find / -type f -perm 777 >> ~/boo/execs.txt
echo -e "\nTop 10 processes are" >> ~/boo/execs.txt
ps aux -m | awk '{print $1,$2,$3,$4,$11}' | head -10 >> ~/boo/execs.txt
