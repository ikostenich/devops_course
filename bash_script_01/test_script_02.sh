sudo find /home -type d -mtime +1 -printf "\n%AD %AT %h %f" | sort -k4 | awk -v green=$(tput setaf 2) -v white=$(tput setaf 7) '{
        $1=green $1
        $2=green $2
        $3=white $3
     } 1'
