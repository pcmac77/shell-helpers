# Shell Helpers

A collection of shell aliases and functions to make daily tasks as an aGalaxy developer easier.

## Setup


Copy the template and edit env to put aGalaxy root password in it.

```bash
cp env-template env
```

Place the following in your `~/.bashrc`

```bash
# Assuming this repo is checked out to ~/src/shell-helpers
# aliases
if [ -f ~/src/shell-helpers/aliases ]; then
    . ~/src/shell-helpers/aliases
fi

# bash functions
if [ -f ~/src/shell-helpers/bashrc ]; then
    . ~/src/shell-helpers/bashrc
fi

```

