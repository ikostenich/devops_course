#!/bin/bash

read -p "Enter A value and press enter. Type \"exit\" to stop input: " A
while :
do
    echo "Type \"exit\" to stop input."
    read input;
    if [ "${input}" = "exit" ];
    then
        break
    fi
    A=${input}
done

read -p "Enter B value and press enter. Type \"exit\" to stop input: " B
while :
do
    echo "Type \"exit\" to stop input."
    read input;
    if [ "${input}" = "exit" ];
    then
        break
    fi
    B=${input}
done

if [ $A -gt $B ]
then
echo "A is greater than B"
elif [ $A -lt $B ]
then
echo "A is less than B"
else
echo "A is equal to B"
fi