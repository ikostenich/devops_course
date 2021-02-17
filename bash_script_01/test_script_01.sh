sudo find /home -type d -mtime +1 -printf "\n%AD %AT %h %f" | sort -k4 | awk -v red=$(tput setaf 1) -v white=$(tput setaf 7) '{
        $1=red $1
        $2=red $2
        $3=white $3
     } 1'
