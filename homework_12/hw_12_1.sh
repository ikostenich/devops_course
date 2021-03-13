#!/bin/bash

echo "Id is: $(cat test_hw12.json | jq '.Id')"

replace_action_string() {
    echo $1
    echo $2
    jq '.Statement[0].Action[0]="s3:CreateBucket"' -c test_hw12.json > test_hw12_temp.json
    rm test_hw12.json
    mv test_hw12_temp.json test_hw12.json
}

add_new_resource_line() {
    jq '.Statement[0].Resource[.Statement[0].Resource| length] |= . + "arn:aws:s3:::hw12-bucket"' -c test_hw12.json > test_hw12_temp.json
    rm test_hw12.json
    mv test_hw12_temp.json test_hw12.json
}

replace_action_string
add_new_resource_line