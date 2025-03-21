#!/bin/bash

# Source the script to test
# Using a relative path from the test file to the script
SCRIPT_DIR="$(dirname "$(dirname "$0")")"
# Don't source the script directly as it contains functions that execute immediately
# Instead, we'll call the script directly in our tests

# Create a temporary directory for test files
setUp() {
  TEST_DIR=$(mktemp -d)
  TEST_LOG="$TEST_DIR/test_access.log"
}

# Clean up after tests
tearDown() {
  rm -rf "$TEST_DIR"
}

# Test that the script correctly identifies when no log is provided
testNoLogProvided() {
  # Capture the output of the script when run with no arguments
  output=$(bash "$SCRIPT_DIR/spike_check" 2>&1)

  # Check that the output contains the expected help message
  assertTrue "Should show help message" "echo '$output' | grep -q 'Specify the log that you want to summarize'"
}

# Test that the script correctly identifies when an empty log is provided
testEmptyLog() {
  # Create an empty log file
  touch "$TEST_LOG"

  # Capture the output of the script when run with an empty log
  output=$(bash "$SCRIPT_DIR/spike_check" "$TEST_LOG" 2>&1)

  # Check that the output contains the expected message for empty logs
  assertTrue "Should detect empty log" "echo '$output' | grep -q 'Empty log or does not exist'"
}

# Test that the script correctly processes a log with sample data
testLogProcessing() {
  # Create a sample log with a few entries
  cat >"$TEST_LOG" <<EOF
192.168.1.1 - - [01/Jan/2023:12:00:00 +0000] "GET /index.html HTTP/1.1" 200 1234
192.168.1.2 - - [01/Jan/2023:12:01:00 +0000] "POST /login HTTP/1.1" 302 0
192.168.1.1 - - [01/Jan/2023:12:02:00 +0000] "GET /dashboard HTTP/1.1" 200 5678
EOF

  # Modify the script to run non-interactively for testing
  # Create a temporary modified version of the script
  TEST_SCRIPT="$TEST_DIR/test_spike_check"
  cp "$SCRIPT_DIR/spike_check" "$TEST_SCRIPT"

  # Modify the script to automatically answer "no" to the geo location prompt
  sed -i 's/read -r geo/geo="no"/' "$TEST_SCRIPT"

  # Capture the output of the script when run with the sample log
  output=$(bash "$TEST_SCRIPT" "$TEST_LOG" 2>&1)

  # Check that the output contains expected analysis results
  # Use more general patterns that will match regardless of exact formatting
  assertTrue "Should find GET requests" "echo '$output' | grep -q 'GET'"
  assertTrue "Should find POST requests" "echo '$output' | grep -q 'POST'"
  assertTrue "Should find /index.html" "echo '$output' | grep -q '/index.html'"
  assertTrue "Should find /login" "echo '$output' | grep -q '/login'"
}

# Load shUnit2
. shunit2
