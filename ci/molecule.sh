#!/usr/bin/env bash
CONTAINER_LIFETIME=2h
if [ $# -eq 0 ]; then
  echo "This script requires command as argument"
  exit 1
fi
DOCKERIMG=${MOLECULE_IMAGE:-'registry.betsys.com/devops/molecule:latest-master'}
ROLEPATH=/tmp/$(basename "${PWD}")
if [ -z "${ANSIBLE_VSPHERE_USER+x}" ] || [ -z "${ANSIBLE_VSPHERE_PASS+x}" ]; then
  echo "Enviroment variables ANSIBLE_VSPHERE_USER and ANSIBLE_VSPHERE_PASS have to be defined"
  exit 1
fi

echo "Using molecule image ${MOLECULE_IMAGE}"
docker pull "${DOCKERIMG}"
CONTAINER_ID=$(docker run -d --rm\
 -v "$(pwd)":/tmp/role_source:ro\
 --env ANSIBLE_VSPHERE_USER\
 --env ANSIBLE_VSPHERE_PASS\
 --env GITLAB_USER="${GIT_USER:-gitlab-ci-token}"\
 --env GITLAB_TOKEN="${GIT_TOKEN:-$CI_BUILD_TOKEN}"\
 --env ROLEPATH="${ROLEPATH}"\
 "${DOCKERIMG}"\
 sleep "${CONTAINER_LIFETIME}")

# configure docker image
docker exec "${CONTAINER_ID}" bash -c "/opt/configure_docker.sh"

# run commands from CI
docker exec "${CONTAINER_ID}" bash -c "cd ${ROLEPATH} && $*"
exit_code_ci=$?

if [ "${exit_code_ci}" == 0 ]; then
  # stop container
  echo "Destroying container ${CONTAINER_ID}"
  docker stop "${CONTAINER_ID}"
else
  echo "Keeping container ${CONTAINER_ID} up for debug. It will self-destroy after ${CONTAINER_LIFETIME}"
fi

exit $exit_code_ci
