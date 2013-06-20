# Makefile for doc.opensuse.org index.html

html:
	perl makeHTML.pl

upload: html
	sh publish.sh

all: html upload
