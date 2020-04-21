#!/bin/bash
# As parameters, use the user names for documentation/release notes.

FILESDOC="index.html archive.html"
FILESRN="index.html"


userconfig="publishusers"
# Example content for $userconfig file:
#   port=[SSH_PORT]
#   server=[SERVER]
#   userdoc=[USER_NAME_DOC]
#   userrn=[USER_NAME_RELEASE_NOTES]

test -s $userconfig && . $userconfig



if [[ $userdoc ]] && [[ $userrn ]] && [[ $port ]] && [[ $server ]] && [[ $1 ]]; then
  while [[ $1 ]]; do
    if [[ $1 == 'doc' ]]; then
      echo "Syncing documentation."
      rsync $FILESDOC -e "ssh -p $port" ${userdoc}@${server}:doc.opensuse.org/htdocs/
    elif [[ $1 == 'rn' ]]; then
      echo "Syncing release notes."
      cd release-notes
      rsync $FILESRN  -e "ssh -p $port" ${userrn}@${server}:release-notes/
    else
      >&2 echo "Not sure how to interpret $1"
    fi
    shift
  done
else
  >&2 echo "Error: Could not sync."
  exit 1
fi
