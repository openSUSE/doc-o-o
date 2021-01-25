#!/bin/bash
# Sync documentation to doc.o.o, needs a config file named `publishusers` in
# the same directory, as shown below.
# There is nothing that needs to be synced to the release notes page currently.

userconfig="publishusers"
# Example content for $userconfig file:
#   port=[SSH_PORT]
#   server=[SERVER]
#   userdoc=[USER_NAME_DOC]
#   userrn=[USER_NAME_RELEASE_NOTES]

test -s $userconfig && . $userconfig



if [[ $userdoc ]] && [[ $port ]] && [[ $server ]]; then
  echo "Syncing documentation."
  rsync -lr -v _site/ -e "ssh -p $port" ${userdoc}@${server}:doc.opensuse.org/htdocs/
else
  >&2 echo "Error: Could not sync."
  exit 1
fi
