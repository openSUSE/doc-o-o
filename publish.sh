#!/bin/bash
# As parameters, use the user names for documentation/release notes.

FILESDOC="index.html opensuse.html"
FILESRN="index.html"

# Add a two-line file that just contains the user names and those will always
# be used.
userconfig="publishusers"
userdoc=$1
userrn=$2

if [[ -f $userconfig ]] && [[ $(cat "$userconfig" | wc -l) = "2" ]]; then
  userdoc=$(head -1 $userconfig)
  userrn=$(tail -1 $userconfig)
fi

if [[ $userdoc ]] && [[ $userrn ]]; then
  if [[ ! $userdoc == '--' ]]; then
    echo "Syncing documentation."
    rsync $FILESDOC -e ssh ${userdoc}@community.opensuse.org:doc.opensuse.org/htdocs/
  else
    echo "Skipping documentation page sync: no user name provided."
  fi
  if [[ ! $userrn == '--' ]]; then
    echo "Syncing release notes."
    cd release-notes
    rsync $FILESRN -e ssh ${userrn}@community.opensuse.org:release-notes/
  else
    echo "Skipping release notes page sync: no user name provided."
  fi
else
  >&2 echo "Error: Could not sync. As parameters, use the correct user names:"
  >&2 echo "  $0 [USER_FOR_DOCUMENTATION] [USER_FOR_RELEASE_NOTES]"
  >&2 echo "To only sync one of the items, use -- as one of the parameters."
  exit 1
fi
