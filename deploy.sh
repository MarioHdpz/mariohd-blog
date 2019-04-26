#!/bin/bash
set -u

GATSBY=`which gatsby`

# Remote configuration
USER="mario"
HOST="mariohd.com"
SSH_AUTH="$USER@$HOST"
STATIC_PATH="/var/www/html"

rm -rf .cache

$GATSBY build

tar -czf build.tar.gz public/

sudo chmod 777 build.tar.gz

ssh -t $SSH_AUTH "sudo rm -rf $STATIC_PATH/*"

scp build.tar.gz $SSH_AUTH:$STATIC_PATH

ssh -t $SSH_AUTH "cd $STATIC_PATH && tar -xzf build.tar.gz && mv public/* . && rm build.tar.gz"

rm build.tar.gz