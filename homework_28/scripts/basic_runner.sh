#!/bin/bash

CONFIG_PATH="$(awk -F "=" '/config_folder_path/ {print $2}' config/testrun_config.ini | tr -d ' ')/"
echo $CONFIG_PATH
TESTRUN_CONFIG_FILE="testrun_config.ini"

read_config_property() {
    echo $(awk -v pattern="$1" -F "=" '$0~pattern{print $2}' $CONFIG_PATH$TESTRUN_CONFIG_FILE | tr -d ' ')
}

#LOCUST_FILE_NAME="$(read_config_property \"project_name\").py"
LOCUST_FILE_NAME="$(read_config_property "project_name").py"
echo "LOCUST_FILE_NAME: $LOCUST_FILE_NAME"
PROMETHEUS_RUNNER_FILE=$(read_config_property "prometheus_runner_file")
echo "PROMETHEUS_RUNNER_FILE: $PROMETHEUS_RUNNER_FILE"
LOG_FILE_NAME=$(read_config_property "log_file_name")
echo "LOG_FILE_NAME: $LOG_FILE_NAME"
MASTER_HOST=$(read_config_property "master_host")
echo "MASTER_HOST: $MASTER_HOST"
MASTER_PORT=$(read_config_property "master_port")
echo "MASTER_PORT: $MASTER_PORT"
LOCUST_UI_PORT=$(read_config_property "locust_ui_port")
echo "LOCUST_UI_PORT: $LOCUST_UI_PORT"
TEST_SCENARIO=$(read_config_property "test_scenario")
echo "TEST_SCENARIO: $TEST_SCENARIO"
USERS_COUNT=$(read_config_property "users")
echo "USERS_COUNT: $USERS_COUNT"
RAMPUP_TIME=$(read_config_property "rampup_time")
echo "RAMPUP_TIME: $RAMPUP_TIME"

SPAWN_RATE=${SPAWN_RATE%.*}
echo "SPAWN_RATE: $SPAWN_RATE"
RUN_TIME=$(read_config_property "test_duration")
echo "RUN_TIME: $RUN_TIME"
BASH_MASTER_CONFIG_FILENAME="basic_config_temp.yml"

#Creating configuration file for locust master with proper values
set_up_config(){    
    touch $CONFIG_PATH$BASH_MASTER_CONFIG_FILENAME
    CONFIG_CONTENTS=$(cat <<-END
locustfile = $LOCUST_FILE_NAME
logfile = $LOG_FILE_NAME
END
)
    echo "$CONFIG_CONTENTS" > $CONFIG_PATH$BASH_MASTER_CONFIG_FILENAME
}

#Function to prepare command for locust master.
prepare_locust_runner(){
    $(set_up_config)
    MASTER_LAUNCH_STRING="locust --config=$CONFIG_PATH$BASH_MASTER_CONFIG_FILENAME"
    echo $MASTER_LAUNCH_STRING
}

run_prometheus_exporter() {
    PROMETHEUS_EXPORTER_LAUNCH_STRING="python $PROMETHEUS_RUNNER_FILE $MASTER_HOST:$LOCUST_UI_PORT"
    echo $PROMETHEUS_EXPORTER_LAUNCH_STRING
}

#Once script is terminated via Ctrl+C only 1 worker is terminater. We need to manually kill them all
shutdown() {
    #Once script is terminated via Ctrl+C only 1 worker is terminater. We need to manually kill them all
    trap SIGINT
    pkill -f "locust --config"
    pkill -f "locust_projects"
    echo "Locust workers terminated"
    pkill -f "$PROMETHEUS_RUNNER_FILE"
    echo "Prometheus exporter terminated"


    #Remove obsolete config file
    rm -f $CONFIG_PATH$BASH_MASTER_CONFIG_FILENAME
    rm -f $CONFIG_PATH$BASH_WORKER_CONFIG_FILENAME

    exit
}

source venv/bin/activate
rm $LOG_FILE_NAME

#EXECUTING kill_locust_workers() function once script is interrupted
trap "shutdown" INT
echo "Starting locust" &&
$(prepare_locust_runner) &
sleep 10 &&
echo "Starting Prometheus exporter" &&
eval $(run_prometheus_exporter) &
sleep 30 &&
echo "Statring Locust test" &&
# curl --data "spawn_rate=$SPAWN_RATE&user_count=$USERS_COUNT" http://$MASTER_HOST:$LOCUST_UI_PORT/swarm &
curl --data "user_count=$USERS_COUNT" http://$MASTER_HOST:$LOCUST_UI_PORT/swarm &
echo "Hit CTRL+C to stop Locust test"
while :; do sleep 10; done

trap SIGINT