retry() {
  local exit_code=""
  local retry_count="0"
  local number_of_retries="${retries:-3}"

  while [ "$retry_count" -le "$number_of_retries" ]; do
    exit_code="0"
    "$@" || exit_code=$?
    if [ "$exit_code" -eq 0 ]; then
      break
    fi
    retry_count=$((retry_count+1))
  done

  return "$exit_code"
}
