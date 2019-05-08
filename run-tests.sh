#!/bin/bash
local config=$1
local test_output_path=$2
echo "Running executable"
if [ "$(uname)" = "Linux" ]; then
  strace "./build.$config/bin/signalrclienttests" --gtest_output=xml:$test_output_path
else
  "./build.$config/bin/signalrclienttests" --gtest_output=xml:$test_output_path
fi
EXITCODE=$?
echo "Finished running with exit code: " $EXITCODE
exit $EXITCODE
