#!/bin/bash

# Run all test files in the tests directory
for test_file in $(find "$(dirname "$0")" -name "*_test.sh"); do
  echo "Running tests in $test_file"
  bash "$test_file"
done
