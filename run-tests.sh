#!/bin/bash
config=$1
test_output_path=$2

# For gcore
apt-get update
apt-get install gdb

dumper() {
  # 1 minute seems to be enough and is less than the timeout
  sleep 60
  gcore -o ./signalrclienttests.core $(pidof signalrclienttests)
}

echo "Running executable"
dumper &
if [ "$(uname)" = "Linux" ]; then
  strace -tT "./build.$config/bin/signalrclienttests" --gtest_output=xml:$test_output_path
else
  "./build.$config/bin/signalrclienttests" --gtest_output=xml:$test_output_path
fi
EXITCODE=$?
echo "Finished running with exit code: " $EXITCODE
exit $EXITCODE
