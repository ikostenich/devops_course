#!/bin/bash

# echo -n "Enter A value and press enter: ";
# read;
# A=${REPLY}

read_value() {
    read -p "Enter $1 value and press enter. Type \"exit\" to stop input: " $1
    while :
    do
        echo "Type \"exit\" to stop input."
        read input;
        if [ "${input}" = "exit" ];
        then
            break
        fi
        ${!1}=${input}
    done
}

compare_values() {
    if [ "${!1}" -gt "${!2}" ]
    then
        echo "$1 is greater than $2"
    elif [ ${!1} -lt ${!2} ]
    then
        echo "$1 is less than $2"
    else
        echo "$1 is equal to $2"
    fi
}

compare_numbers(){
    compare_values $1 $2
}

read_value A
read_value B
read_value C

compare_numbers A B
compare_numbers A C
compare_numbers B C