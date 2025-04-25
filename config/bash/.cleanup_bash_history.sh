#!/bin/bash

# =============================================
# Clean Bash History Script
#
# Safely removes duplicates from ~/.bash_history
# while preserving order and preventing data loss
# =============================================

# ---- Configuration ----
readonly BASH_HISTORY_PATH="$HOME/.bash_history"
readonly HISTORY_BACKUP_PATH="$BASH_HISTORY_PATH.bak"
readonly TEMP_CLEANED_HISTORY_PATH="/tmp/cleaned_bash_history.$$"  # $$ ensures unique temp file
readonly LOCK_FILE_PATH="/tmp/bash_history_cleanup.lock"

# ---- Main Execution ----
main() {
  setup_cleanup_hooks
  acquire_processing_lock
  create_safety_backup
  process_history_file
}

# ---- Functions ----
# Ensures cleanup of temp files on script exit
setup_cleanup_hooks() {
  cleanup_temp_files() {
    rm -f "$TEMP_CLEANED_HISTORY_PATH" "$LOCK_FILE_PATH"
  }
  trap cleanup_temp_files EXIT
}

# Prevents concurrent execution that could corrupt history
acquire_processing_lock() {
  exec 200>"$LOCK_FILE_PATH"
  flock -w 5 200 || exit 1  # Wait max 5 seconds for lock
}

# Preserves original in case processing fails
create_safety_backup() {
  cp "$BASH_HISTORY_PATH" "$HISTORY_BACKUP_PATH" 2>/dev/null
}

# Core processing logic: deduplicates while maintaining order
process_history_file() {
  [[ ! -f "$BASH_HISTORY_PATH" ]] && return

  # Reverse-process-reverse maintains chronological order
  tac "$BASH_HISTORY_PATH" | awk '!seen[$0]++' | tac > "$TEMP_CLEANED_HISTORY_PATH" &&

  # Only overwrite if processing succeeded and temp file has content
  [[ -s "$TEMP_CLEANED_HISTORY_PATH" ]] &&
  mv "$TEMP_CLEANED_HISTORY_PATH" "$BASH_HISTORY_PATH" &&

  # Maintain secure permissions
  chmod 600 "$BASH_HISTORY_PATH"
}

main "$@"
