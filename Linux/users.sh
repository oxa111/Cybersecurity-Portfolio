#!/bin/bash
if [ $(whoami) != 'sysadmin' ]
then
echo "I am sysadmin"
else
echo "get out of here"
fi

