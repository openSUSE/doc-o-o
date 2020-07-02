.PHONY: html upload upload-rn upload-doc clean

build:
	bundle exec jekyll build

upload: build
	bash publish.sh doc

clean:
	rm -r _site
