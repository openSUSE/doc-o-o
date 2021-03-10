.PHONY: all build serve upload upload_rn_config clean

# Example content for $(userconfig) file:
#   port=[SSH_PORT]
#   server=[SERVER]
#   userdoc=[USER_NAME_DOC]
#   userrn=[USER_NAME_RELEASE_NOTES]
userconfig := $(PWD)/publishusers

all: build upload upload_rn_config

build:
	bundle exec jekyll build
	cp "htaccess-doc-o-o" "_site/.htaccess"

serve:
	bundle exec jekyll serve

upload: build
	test -s $(userconfig) && source $(userconfig); \
	if [[ $$userdoc ]] && [[ $$port ]] && [[ $$server ]]; then \
	  echo "Syncing documentation."; \
	  rsync -lr -v "_site/" -e "ssh -p $$port" $${userdoc}@$${server}:doc.opensuse.org/htdocs/ ; \
	else \
	  exit 1; \
	fi

upload_rn_config: rn-config/bin/update_release_notes rn-config/etc/releasenotes
	test -s $(userconfig) && source $(userconfig); \
	if [[ $$userrn ]] && [[ $$port ]] && [[ $$server ]]; then \
	  echo "Syncing release notes config."; \
	  rsync -lr -v rn-config/{bin,etc} -e "ssh -p $$port" "$${userrn}@$${server}":'~' ; \
	else \
	  exit 1; \
	fi

clean:
	rm -r _site
