# Makefile for doc.opensuse.org index.html

html:
	perl makeHTML.pl

# FIXME: Does not really work without user names anymore.
upload: html
	sh publish.sh

clean: index.html opensuse.html release-notes/index.html
	rm $^

all: html upload
