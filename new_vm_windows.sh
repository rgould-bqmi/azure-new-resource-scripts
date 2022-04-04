#!/bin/bash

#IMG="MicrosoftWindowsServer:WindowsServer:2016-datacenter-gensecond:Latest"
#IMG="MicrosoftWindowsServer:WindowsServer:2019-Datacenter-Core:Latest"
IMG="MicrosoftWindowsServer:WindowsServer:2019-datacenter-gensecond:Latest"
#IMG="MicrosoftWindowsDesktop:Windows-10:win10-21h2-pro-g2:Latest"
#IMG="MicrosoftWindowsDesktop:windows-11:win11-21h2-pro:Latest"

un='rlgould'
TAG=$(date +'%s')

COMNAME=$(mktemp -u ${un}-XXXXXXXXXXXXXXX)
COMNAME="${COMNAME:0:15}"
COMNAME="${COMNAME,,}"

az vm create \
  --admin-username "${un}" \
  --admin-password "ChangeThis${TAG}" \
  --authentication-type password \
  --computer-name "${COMNAME}" \
  --custom-data "echo" \
  --image "$IMG" \
  --location australiaeast \
  --name "${un}_${TAG}" \
  --os-disk-name "DISK_${un}_${TAG}" \
  --resource-group "RLGRG" \
  --size Standard_B1s \
  --verbose 2>&1 | tee "ms_${un}_${TAG}.log"

