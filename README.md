# doc.opensuse.org

Built with [openSUSE Jekyll Theme](https://github.com/openSUSE/jekyll-theme).

Note that this repo only contains the home page of the site.
Actual documents are from:

- https://github.com/SUSE/doc-sle
- https://github.com/openSUSE/release-notes-openSUSE

## Development

### How to set up the environment?

```bash
sudo zypper in ruby ruby-devel
bundle install
```

### How to build?

```bash
bundle exec jekyll build
```

The resulting site will be in the `_site` directory.

### How to serve the site locally?

```bash
bundle exec jekyll serve
```

Visit <http://localhost:4000/> in your browser.
