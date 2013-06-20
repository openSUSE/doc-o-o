#!/bin/bash

FILES="index.html opensuse.html rtfmindex.html"
rsync $FILES -e ssh community.opensuse.org:doc.opensuse.org/htdocs/
