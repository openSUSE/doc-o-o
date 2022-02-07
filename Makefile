.PHONY: all build serve upload update_deps clean upload_rn_config update_tw_docs update_tw_docs_config

# == SSH SETUP
# Example content for $(userconfig) file:
#   port=[SSH_PORT]
#   server=[SERVER]
#   userdoc=[USER_NAME_DOC]
#   userrn=[USER_NAME_RELEASE_NOTES]
userconfig := $(PWD)/publishusers


all: build upload upload_rn_config

# JEKYLL HOMEPAGE BUILD
build:
	bundle exec jekyll build
	cp "htaccess-doc-o-o" "_site/.htaccess"

# JEKYLL HOMEPAGE LOCAL SERVER
serve:
	bundle exec jekyll serve

# JEKYLL HOMEPAGE UPDATE
upload: build publishusers
	test -s $(userconfig) && source $(userconfig); \
	if [[ $$userdoc ]] && [[ $$port ]] && [[ $$server ]]; then \
	  echo "Syncing documentation."; \
	  rsync -lr -v "_site/" -e "ssh -p $$port" $${userdoc}@$${server}:doc.opensuse.org/htdocs/ ; \
	else \
	  exit 1; \
	fi

# UPDATE GEMS FOR JEKYLL
update_deps: Gemfile
	bundle update

# JEKYLL HOMEPAGE CLEANUP
clean:
	rm -r _site


# UPLOAD NEW CONFIG/UPDATE SCRIPT FOR RELEASE NOTES SYNC
upload_rn_config: rn-config/bin/update_release_notes rn-config/etc/releasenotes publishusers
	test -s $(userconfig) && source $(userconfig); \
	if [[ $$userrn ]] && [[ $$port ]] && [[ $$server ]]; then \
	  echo "Syncing release notes config."; \
	  rsync -lr -v rn-config/{bin,etc} -e "ssh -p $$port" "$${userrn}@$${server}":'~' ; \
	else \
	  exit 1; \
	fi


# TUMBLEWEED COMMUNITY DOCS
# Source repo: https://github.com/openSUSE/openSUSE-docs-revamped-temp
update_tw_docs: publishusers
	test -s $(userconfig) && source $(userconfig); \
	  ssh -p "$$port" "$${userdoc}@$${server}" '~/bin/update_tw_docs'

# UPLOAD NEW CONFIG/UPDATE SCRIPT FOR TUMBLEWEED COMMUNITY DOCS (SYSTEMD TIMER)
upload_tw_docs_config: tw-docs-config/systemd/update_tw_docs.* tw-docs-config/bin/update_tw_docs publishusers
	test -s $(userconfig) && source $(userconfig); \
	if [[ $$userrn ]] && [[ $$port ]] && [[ $$server ]]; then \
	  echo "Syncing Tumbleweed Community docs config."; \
	  rsync -lr -v tw-docs-config/systemd/update_tw_docs.* -e "ssh -p $$port" "$${userdoc}@$${server}":'~/.config/systemd/user/' ; \
	  rsync -lr -v tw-docs-config/bin/* -e "ssh -p $$port" "$${userdoc}@$${server}":'~/bin/' ; \
	  ssh -p "$$port" "$${userdoc}@$${server}" 'systemctl --user daemon-reload'; \
	else \
	  exit 1; \
	fi
