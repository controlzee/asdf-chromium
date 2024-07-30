<div align="center">

# asdf-chromium [![Build](https://github.com/controlzee/asdf-chromium/actions/workflows/build.yml/badge.svg)](https://github.com/controlzee/asdf-chromium/actions/workflows/build.yml) [![Lint](https://github.com/controlzee/asdf-chromium/actions/workflows/lint.yml/badge.svg)](https://github.com/controlzee/asdf-chromium/actions/workflows/lint.yml)

[chromium](https://github.com/controlzee/asdf-chromium) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add chromium
# or
asdf plugin add chromium https://github.com/controlzee/asdf-chromium.git
```

chromium:

```shell
# Show all installable versions
asdf list-all chromium

# Install specific version
asdf install chromium latest

# Set a version globally (on your ~/.tool-versions file)
asdf global chromium latest

# Now chromium commands are available
chromium --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/controlzee/asdf-chromium/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Jordan](https://github.com/controlzee/)
