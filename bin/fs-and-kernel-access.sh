#!/usr/bin/env bash

TIME_FS=${TIME_FS:-10}
TIME_KERNEL=${TIME_KERNEL:-10}

echo
echo "Viewing filesystem access for $TIME_FS seconds"

sudo gtimeout $TIME_FS fs_usage | grep -v grep | grep -v iTerm2

echo
echo "Viewing kernel access for $TIME_KERNEL seconds"

sudo gtimeout $TIME_KERNEL syscallbypid.d

exit 0
