#!/usr/bin/env bash
# shellcheck disable=SC1090

. "$(dirname "${BASH_SOURCE[0]}")/lib.sh" || exit 1

section 'Check no CR (0x0d) in tracked text files'
libci-list-tracked-files -0 \
    | libci-filter-text-files -0 \
    | xargs -0 libci-is-not-text-with-cr
exit_code_eol=$?
exit_code_msg $exit_code_eol; echo

section 'Check trailing spaces'
libci-list-tracked-files -0 \
    | libci-filter-text-files -0 \
    | xargs -0 libci-is-not-text-with-trailing-whitespace
exit_code_ts=$?
exit_code_msg $exit_code_ts; echo

section 'Check indentation'
libci-list-tracked-files -0 \
    | libci-filter-text-files -0 \
    | (grep -vz '^\.gitmodules$' || true) \
    | xargs -0 libci-is-indented-by-spaces-only
exit_code_indent=$?
exit_code_msg $exit_code_indent; echo

section 'Check text files end with a line feed (0x0a)'
libci-list-tracked-files -0 \
    | libci-filter-text-files -0 \
    | libci-filter-text-files -0 \
    | xargs -0 libci-is-empty-or-ends-with-lf
exit_code_eof=$?
exit_code_msg $exit_code_eof; echo

section 'Check hashbangs'
libci-list-tracked-files -0 \
    | libci-filter-text-files -0 \
    | libci-filter-executable-files -0 \
    | grep -vz '\.conf$' \
    | grep -vz '\.j2$' \
    | grep -vz '\.yml$' \
    | grep -vz '\.pub$' \
    | xargs -0 libci-has-correct-hashbang
exit_code_hashbang=$?
exit_code_msg $exit_code_hashbang; echo

[ $exit_code_eol -eq 0 ] \
    && [ $exit_code_ts -eq 0 ] \
    && [ $exit_code_indent -eq 0 ] \
    && [ $exit_code_eof -eq 0 ] \
    && [ $exit_code_hashbang -eq 0 ] \
    && :
exit_code=$?

exit $exit_code
