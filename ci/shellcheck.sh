#!/usr/bin/env bash
# shellcheck disable=SC1090

. "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

cd "$PROJECT_ROOT" || abort

section 'ShellCheck'

echo_exec libci_shellcheck_pull || abort

echo_eval "libci-list-tracked-files -0" \
    "| libci-filter-shell-scripts -0" \
    "| libci_shellcheck_run -0"
