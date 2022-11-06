#! /bin/bash

# To run the compliance check for Terraform Module

# vars declaration



TF_PATH="../../deploy/modules"
RESULT_FILE="results_json.json"
OUTPUT_FILE="checkov_compact_results.json"

rm $RESULT_FILE $OUTPUT_FILE


# checkov command

checkov -d $TF_PATH --output-file-path . -o json 

cat $RESULT_FILE | jq .summary >$OUTPUT_FILE




