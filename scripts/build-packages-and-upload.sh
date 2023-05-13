#!/bin/bash
# builds packages and uploads them to a folder called rc (release candidate) on the updates server you can then move this rc folder to a folder named after the appropriate release
set -e && {
set -ux
dirname_0="$(dirname -- "${0}")"
cd "${dirname_0}"/.. || exit
export SERVER=updates
export HTTP_DIR=/usr/share/nginx/html/
for file in profiles/devices/*
do
	ansible-playbook -e @"${file}" -e @profiles/management/althea-release.yml firmware-build.yml
done

rsync -ahz --delete build/bin/packages "${SERVER}":"${HTTP_DIR}"/rc/
rsync -ahz --delete build/bin/targets "${SERVER}":"${HTTP_DIR}"/
}
