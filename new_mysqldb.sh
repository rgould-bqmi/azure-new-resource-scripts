#!/bin/bash

un='rlgould'
TAG=$(date +'%s')

az mysql server create \
--admin-user "${un}" \
--admin-password "ChangeThis${TAG}" \
--location australiaeast \
--name "MySQL${TAG}" \
--resource-group "RLGRG" \
--verbose \
--version '8.0' 2>&1 | tee "mysql_${un}_${TAG}.log"

exit 0
## --minimal-tls-version TLS1_2 \
--name "mysql_${un}_${TAG}" \
