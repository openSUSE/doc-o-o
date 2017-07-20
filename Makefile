# Makefile for doc.opensuse.org index.html

.PHONY: html upload upload-rn upload-doc clean
all: html upload

html:
	perl makeHTML.pl

upload-rn: html
	bash publish.sh rn

upload-doc: html
	bash publish.sh doc

upload: upload-rn upload-doc

clean: index.html opensuse.html release-notes/index.html
	rm $^


