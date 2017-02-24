#!/bin/bash
# As parameters, use the user names for documentation/release notes.

FILESDOC="index.html opensuse.html"
FILESRN="index.html"

if [[ $1 ]] && [[ $2 ]]; then
  if [[ ! $1 == '--' ]]; then
    rsync $FILESDOC -e ssh ${1}@community.opensuse.org:doc.opensuse.org/htdocs/
  fi
  if [[ ! $2 == '--' ]]; then
    cd release-notes
    rsync $FILESRN -e ssh ${2}@community.opensuse.org:release-notes/
  fi
else
  >&2 echo "Error: Could not sync. As parameters, use the correct user names:"
  >&2 echo "  $0 [USER_FOR_DOCUMENTATION] [USER_FOR_RELEASE_NOTES]"
  >&2 echo "To only sync of the items, use -- as one of the parameters."
  exit 1
fi
