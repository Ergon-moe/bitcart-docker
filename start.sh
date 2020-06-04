#!/usr/bin/env bash

. helpers.sh
get_profile_file "$NAME" false

. ${BASH_PROFILE_SCRIPT}

cd "$BITCART_BASE_DIRECTORY"
# setup pipe and it's listener
mkfifo queue
nohup sh -c "tail -f queue | sh" > /dev/null &
echo $! > listener.pid
USER_UID=${UID} USER_GID=${GID} docker-compose -p "$NAME" -f compose/generated.yml up --remove-orphans -d