#!/bin/bash
set -eux
dirname_0="$(dirname -- "${0}")"
cd "${dirname_0}"/..

ansible-playbook -e @profiles/devices/mikrotik_hap-ac2-extender.yml -e @profiles/management/althea-managed.yml build-extender.yml
