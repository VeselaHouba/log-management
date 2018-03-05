#!/usr/bin/env bash
# shellcheck disable=SC1090

export LIBCI_PROJECT_NAME="user-management"

export PROJECT_ROOT
PROJECT_ROOT=$(realpath "$(dirname "${BASH_SOURCE[0]}")/..")

export LIBCI_PROJECT_ROOT=$PROJECT_ROOT

. "$PROJECT_ROOT/libci/lib.sh" || exit 1
