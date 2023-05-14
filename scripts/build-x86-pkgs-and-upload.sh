#!/bin/bash
set -ux
dirname_0="$(dirname -- "${0}")"
cd "${dirname_0}"/..
export SERVER=updates
export HTTP_DIR=/usr/share/nginx/html/

ansible-playbook -e @profiles/devices/x86_64.yml -e @profiles/management/althea-release.yml firmware-build.yml

rsync -ahz --delete build/bin/packages $SERVER:$HTTP_DIR/rc/
rsync -ahz --delete build/bin/targets $SERVER:$HTTP_DIR/
