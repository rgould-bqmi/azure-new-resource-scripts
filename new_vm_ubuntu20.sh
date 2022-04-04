#!/bin/bash


un='rlgould'
TAG=$(date +'%s')

COMNAME=$(mktemp -u ${un}-XXXXXXXXXXXXXXX)
COMNAME="${COMNAME:0:15}"
COMNAME="${COMNAME,,}"

# IMG="Canonical:0001-com-ubuntu-server-focal:20_04-lts-gen2:Latest"
# IMG="Canonical:0001-com-ubuntu-server-focal:20_04-lts-gen2:Latest"
IMG="Canonical:0001-com-ubuntu-server-focal:20_04-lts-gen2:Latest"

az vm create \
  --admin-username "${un}" \
  --admin-password "ChangeThis${TAG}" \
  --authentication-type password \
  --computer-name "${COMNAME}" \
  --custom-data "apt update ; apt upgrade ; apt install -y python3.9-full lamp-server^" \
  --image "$IMG" \
  --location australiaeast \
  --name "${un}_${TAG}" \
  --os-disk-name "DISK_${un}_${TAG}" \
  --resource-group "RLGRG" \
  --size Standard_B1s \
  --verbose 2>&1 | tee "linux_${un}_${TAG}.log"

IP=$(cat "linux_${un}_${TAG}.log" | egrep 'publicIpAddress' | egrep -o '([0-9]{1,3}\.){3}[0-9]{1,3}')

printf "Log in with\nssh ${un}@${IP}\nwith password\nChangeThis${TAG}\n\n"

exit 0
