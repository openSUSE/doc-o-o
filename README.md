# doc.opensuse.org

Built with [openSUSE Jekyll Theme](https://github.com/openSUSE/jekyll-theme).

Note that this repo only contains the home page of the site.
Actual documents are from:

- https://github.com/SUSE/doc-sle
- https://github.com/openSUSE/release-notes-openSUSE

## Development

### Setting up the environment

```bash
sudo zypper in ruby ruby-devel
bundle install
```

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

Get the details about the SSH setup from someone in the know (e.g. @sknorr).
Have your SSH key added to the `.ssh/authorized_keys` on the server.

Create a file `publishusers` within the local repository clone:

```bash
port=[SSH_PORT]
server=[SERVER]
userdoc=[USER_NAME_DOC]
userrn=[USER_NAME_RELEASE_NOTES]
```

### Syncing documentation navigation

```bash
make upload
```

### Syncing configuration for the release notes

```bash
make upload_rn_config
```

### Building and syncing documentation content

1. Clone the `doc-sle` repository locally: `git clone https://github.com/SUSE/doc-sle`
2. Switch to the correct branch in the `doc-sle` repository: `git -C /path/to/doc-sle checkout ...`
3. Open `doc-build-script` from this repository and make sure the following are set correctly (*!!*):
   * referenced guides (`$guides`)
   * the openSUSE Leap version number (`$version`)
4. Run the script, from within this repo: `./doc-build-script /path/to/doc-sle`
