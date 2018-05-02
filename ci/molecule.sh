#!/usr/bin/env bash
rolename=$(basename "${PWD}")
docker run --rm\
 -v "$(pwd)":/tmp/"${rolename}":ro\
 -v /var/run/docker.sock:/var/run/docker.sock\
 -w /tmp/"${rolename}"\
 retr0h/molecule:latest\
 sudo molecule test
