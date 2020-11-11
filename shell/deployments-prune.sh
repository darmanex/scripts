#!/bin/sh
#
# This script is for pruning deployments on OKD (Openshift) master node
# To make this script automated execution, please put on cronjob
# eg: execute at 00:00 on day-of-month 1
# 0 0 1 * * /path/of_your_scripts/deployments-prune.sh
#

OKD_URL=https://okd-host-domain.com
OKD_PORT=8443
OKD_UNAME=okd_username
OKD_PASS=okd_password
LOGDIR=/root/logs
CURDATE=$(date)
LOGFILE=$LOGDIR/deployments-prune.log

oc login $OKD_URL:$OKD_PORT -u=$OKD_UNAME -p=$OKD_PASS --insecure-skip-tls-verify

oc adm prune deployments --orphans --keep-complete=3 --keep-failed=1 --keep-younger-than=43200m --confirm > $LOGFILE

echo "Last checked at $CURDATE" >> $LOGFILE
