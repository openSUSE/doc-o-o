.PHONY: build upload clean

build:
	bundle exec jekyll build
	cp htaccess-doc-o-o _site/.htaccess

upload: build
	bash publish.sh

clean:
	rm -r _site
