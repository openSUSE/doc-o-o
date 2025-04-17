# doc.opensuse.org

Built with [openSUSE Jekyll Theme](https://github.com/openSUSE/jekyll-theme).

Note that this repo only contains the home page of the site.
Actual documents are from:

- https://github.com/SUSE/doc-sle
- https://github.com/openSUSE/release-notes-openSUSE

## Development

### Setting up the environment

```bash
sudo zypper in ruby ruby-devel ruby2.5-rubygem-bundler ruby2.5-rubygem-eventmachine gcc-c++
bundle install
```

### Making changes

Most changes, such as setting up a new product or guide, need to be made in the file `_config.yml`.


### Building the navigation

```bash
make build
```

The resulting site will be in the `_site` directory.

### Serving the navigation locally

```bash
make serve
```

Visit <http://localhost:4000/> in your browser.
Press Ctrl-C to stop serving the site.


## Syncing the site

### Prerequisites

Contact the [openSUSE admin team](https://progress.opensuse.org/projects/opensuse-admin) to be granted VPN access, and SSH access to relsync@pinot.infra.opensuse.org (was community-i-o-o).
For that you need a GPG key with the encryption capability. 


### Adding release notes for new release
Make sure that [rn-config/etc/release-notes](https://github.com/openSUSE/doc-o-o/blob/main/rn-config/etc/releasenotes) has required entry.
Such configuration then needs to be deployed to pinot-i-o-o.
	

### Syncing documentation navigation

The make upload no longer works as community was decomissioned.
See [poo#162020](https://progress.opensuse.org/issues/162020) ticket for fixing of the process.

Make a local build && create archive of the "_site" build dir.
Extract _site archive or rsync _site/* into community2.infra.opensuse.org:/srv/www/vhosts-legacy/doc-htdocs/
Ask admin@opensuse.org for root access or ping lkocman.


### Syncing configuration for the release notes

```bash
make upload_rn_config
```

### Setting the current docs version

First make sure the correct version is set in `publishusers`.

```bash
make set_docs_current_version
```

### Building and syncing documentation content

1. Clone the `doc-sle` repository locally: `git clone https://github.com/SUSE/doc-sle`
2. Switch to the correct branch in the `doc-sle` repository: `git -C /path/to/doc-sle checkout ...`
3. Open `doc-build-script` from this repository and make sure the following are set correctly (*!!*):
   * referenced guides (`$guides`)
   * the openSUSE Leap version number (`$version`)
4. Run the script, from within this repo: `./doc-build-script /path/to/doc-sle`
5. (Optional) If a new version has been released and the links still point to the older version, see [Setting the current docs version](#setting-the-current-docs-version)
