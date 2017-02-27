# Makefile for doc.opensuse.org index.html


ifndef USERDOC
  USERDOC := --
endif
ifndef USERRN
  USERRN := --
endif

.PHONY: html upload clean
all: html upload

html:
	perl makeHTML.pl

upload: html
	bash publish.sh $(USERDOC) $(USERRN)

clean: index.html opensuse.html release-notes/index.html
	rm $^


