#!/bin/bash
if [ -d /etc ]
then
echo "The /etc directory exists!"
fi

if [ ! -d /my_cool_folder ]
then
echo "It doesn't exist"
fi

if [ ! -f /etc/passwd ] 
then
echo "password file exists"
else
echo "nope doesn't exist"
fi

