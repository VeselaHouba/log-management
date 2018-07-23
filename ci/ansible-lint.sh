#!/usr/bin/env bash
# shellcheck disable=SC1090

. "$(dirname "${BASH_SOURCE[0]}")/lib.sh" || exit 1

ANSIBLE_LINTER_IMAGE=registry.betsys.com/org/ansible-linter:latest-master

echo_exec docker run \
    -t \
    --rm \
    -v "$PROJECT_ROOT":/source:ro \
    "$ANSIBLE_LINTER_IMAGE" \
    /bin/ansible-lint.sh || exit $?
