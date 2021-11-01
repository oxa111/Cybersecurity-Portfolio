#!/bin/bash
states=("Nebraska" "Hawaii" "Montana" "Alaska" "PA")

for state in ${states[@]};
do
if [ $state == "Hawaii" ];
then
echo "Hawaii is the best"
else
echo "I'm not that fond of Hawaii"
fi
done

nums=$(echo {0..9})

for num in ${nums[@]};
do
if [ $num =3 ] then
echo $num
fi
done

