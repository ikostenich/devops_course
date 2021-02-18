#!/bin/bash
read_servers_list () {
  COUNTER=0
  while IFS= read -r line;
    do
      (( COUNTER++ ))
      echo "Line $COUNTER: $line"
    done < servers_list
}

convert_to_uppercase () {
  INPUT=$1
  echo ${INPUT^^}
}

convert_to_lowercase () {
  INPUT=$1
  echo $INPUT | awk '{print tolower($0)}'
}

print_array_elements () {
  read -t 10 -sp "Enter variable value: " input
  tr -d '\n' <<< "$input"
  if [ "$input" ]
  then
    LIST=( $input )
  else
    source variables_file
    LIST=( $SENT )
  fi

  echo
  echo ${LIST[0]}
  echo ${LIST[-1]}
}

read_servers_list
convert_to_uppercase "test"
convert_to_lowercase "TEST"
print_array_elements
