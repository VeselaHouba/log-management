#!/usr/bin/env bash
# shellcheck disable=SC1090
# This simple script will stop after unsuccessful execution, so you have
# oportunity to investigate machine before it's destroyed.
set -e
. "$(dirname "${BASH_SOURCE[0]}")/lib.sh" || exit 1

scenarios=$(ls molecule/)
molecule="$(dirname "$0")/molecule.sh"
for scenario in ${scenarios}; do
  command="molecule destroy --scenario-name=${scenario} \
  && molecule test --scenario-name=${scenario} --destroy=never \
  && molecule destroy --scenario-name=${scenario}"
  echo_exec "${molecule}" "${command}"
done
