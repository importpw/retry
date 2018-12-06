retry() {
  local exit_code=""
  local retry_count="0"
  local number_of_retries="${retries:-3}"

  while [ "$retry_count" -lt "$number_of_retries" ]; do
    exit_code="0"
    "$@" || exit_code=$?
    if [ "$exit_code" -eq 0 ]; then
      break
    fi
    # TODO: add exponential backoff
    retry_count=$(( retry_count + 1 ))
  done

  return "$exit_code"
}
