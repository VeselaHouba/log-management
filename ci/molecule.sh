#!/usr/bin/env bash
DOCKERIMG=registry.betsys.com/org/ansible-linter:latest-master
rolename=$(basename "${PWD}")
if [ -z "${ANSIBLE_VSPHERE_USER+x}" ] || [ -z "${ANSIBLE_VSPHERE_PASS+x}" ]; then
  echo "Enviroment variables ANSIBLE_VSPHERE_USER and ANSIBLE_VSPHERE_PASS have to be defined"
  exit 1
fi
cp molecule/default/vmware/vsphere_credentials_template.yml molecule/default/vmware/vsphere_credentials.yml
sed -i "s/USER/${ANSIBLE_VSPHERE_USER}/g" molecule/default/vmware/vsphere_credentials.yml
sed -i "s/PASSWORD/${ANSIBLE_VSPHERE_PASS}/g" molecule/default/vmware/vsphere_credentials.yml
sed -i "s/_ROLE_NAME_PLACEHOLDER_/${rolename}/g" molecule/default/molecule.yml molecule/default/playbook.yml
chmod 644 molecule/default/vmware/id_rsa
rolename=$(basename "${PWD}")
docker pull "${DOCKERIMG}"
docker run --rm\
 -v "$(pwd)":/tmp/"${rolename}":ro\
 -v /var/run/docker.sock:/var/run/docker.sock\
 -w /tmp/"${rolename}"\
 "${DOCKERIMG}"\
 molecule "$@"
