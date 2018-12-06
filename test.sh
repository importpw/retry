#!/usr/bin/env import
set -eu
import "assert@2.1.3"
. "./retry.sh"

# This will pass on the first attempt
assert_exit 0 retry echo foo

# This will always fail
assert_exit 7 retry sh -c "echo foo && exit 7"

# This function fails the first two times it is invoked
do_work_count=0
do_work() {
  if [ "$do_work_count" -lt 2 ]; then
    do_work_count=$((do_work_count+1))
    printf failing
    return "$do_work_count"
  fi
  printf ok
}

assert_exit 0 retry do_work

# Test expected output
do_work_count=0
assert_equal "$(retry do_work)" "failingfailingok"

# Test exit code works properly
do_work_count=0
retries=1 assert_exit 1 retry do_work

do_work_count=0
retries=2 assert_exit 2 retry do_work
