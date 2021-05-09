#!/bin/bash
CURRENT_DIR=$(pwd)
LOGFILE_NAME="bash_script_01.log"
LOG_HEADER="Date 	User 	PID 	Function 	Message"
echo "$LOG_HEADER"> $CURRENT_DIR/$LOGFILE_NAME

log_message () {
 MESSAGE=$1
 FUNCTION_NAME=$2
 CUR_DATE=$(date +"%D %T")
 PROCESS_PID=$(pgrep -f "homework_6.sh" | xargs | awk '{print $1}')
 LOG_STRING="$CUR_DATE 	$USER 	$PROCESS_PID 	$FUNCTION_NAME 	$MESSAGE"
 echo $LOG_STRING >> $CURRENT_DIR/$LOGFILE_NAME
}

directories_list () {
 log_message "Printing directories list:" ${FUNCNAME[0]}
 sudo find /home -type d -mtime +5 -printf "\n%AD %AT %h %f" | sort -k4 | awk -v red=$(tput setaf 1) -v white=$(tput setaf 7) '{
        $1=red $1
        $2=red $2
        $3=white $3
     } 1'
}


files_list () {
 log_message "Printing files list:" ${FUNCNAME[0]}
 sudo find /home -type f -mtime +5 -printf "\n%AD %AT %h %f" | sort -k4 | awk -v green=$(tput setaf 2) -v white=$(tput setaf 7) '{
        $1=green $1
        $2=green $2
        $3=white $3
     } 1'
}

system_info () {
 RUNNING_PROCESSES_NUMBER=$(ps -A | awk 'END {print NR}')
 CPU_LOAD=$(top -b -n 1 | grep %Cpu | awk '{print $2}')
 RAM_FREE=$(top -b -n 1 | grep 'MiB Mem' | awk '{print $8}')
 DISK_ROOT_FREE=$(df -h | grep "/$" | awk '{print $4}')
 log_message "Printing System state:" ${FUNCNAME[0]}
 echo "processes_num	cpu_load	ram_free	disk_free"
 echo "$(tput setaf 1)$RUNNING_PROCESSES_NUMBER		$(tput setaf 2)$CPU_LOAD	 	$(tput setaf 6)$RAM_FREE	 	$(tput sgr 0)$DISK_ROOT_FREE"
}

modify_hosts () {
 HOSTS_FILE="/etc/hosts"
 TARGET_STRING="192.168.3.1 myapp.com"

 if [[ $(cat $HOSTS_FILE | grep "192.168.3.1") ]];
  then
   echo "String found. Nothing to write"
 else
  echo "String not found"
  log_message "Writing $TARGET_STRING to $HOSTS_FILE" ${FUNCNAME[0]}
  sudo echo "$TARGET_STRING" >> $HOSTS_FILE
 fi
}

modify_hosts_rewrite () {
 HOSTS_FILE="/etc/hosts"
 TARGET_STRING="192.168.3.1 myapp.com"
 TARGET_STRING_PART="myapp.com"

 if [[ $(cat $HOSTS_FILE | grep "$TARGET_STRING_PART") ]];
  then
   echo "String found."
   while :
   do
    log_message "Asking user to confirm rewrite." ${FUNCNAME[0]}
    read -n1 -p "Rewrite? (y/n)" REWRITE
    echo
    case $REWRITE in
     y|Y) 
      TARGET_LINE_NUMBER=$(grep -n $TARGET_STRING_PART $HOSTS_FILE | awk '{print $1}' FS=':')
      SED_STRING=$TARGET_LINE_NUMBER
      SED_STRING+="d"
      log_message "Target Line discovered. Line number: $TARGET_LINE_NUMBER" ${FUNCNAME[0]}
      log_message "Removing string" ${FUNCNAME[0]}
      SED_COMMAND="sudo sed -i '$SED_STRING' $HOSTS_FILE"
      /bin/sh -c "$SED_COMMAND"
      break
      ;;
     n|N)
      echo "Skipping rewrite"
      break
      ;;
     *) echo "invalid input" ;;
     esac
    done
 else
  echo "String not found"
  log_message "Writing $TARGET_STRING to $HOSTS_FILE" ${FUNCNAME[0]}
  sudo echo "$TARGET_STRING" >> $HOSTS_FILE
 fi
}

delete_me () {
 while :
  do
  echo "loop iteration"
  FILE_EXISTENCE=$(ls -l | grep "DELETE_ME")
  if [[ $FILE_EXISTENCE ]]
   then
    log_message "File discovered." ${FUNCNAME[0]}
    > temp.txt
    date +"%T" >> temp.txt
    break
   else
    echo "sleeping"
    sleep 5
   fi
 done
}


directories_list
files_list
system_info
modify_hosts
modify_hosts_rewrite
delete_me
