#!/bin/bash

# Allows running composer commands under different PHP versions
# Usage: scomposer.sh [PHP_VERSION] [COMPOSER_COMMAND]
# Example: scomposer.sh 7.4.23 update

# Assumes PHP was installed via `brew install shivammathur/php/php@8.1`

# Get the current PHP version from the first line of the php -v command.
# PHP 8.1.23 (cli) (built: Sep  1 2023 00:30:14) (NTS)
CURRENT_PHP=$(php -v | head -1 | cut -c5-7)

# Homebrew installs in different locations on Intel vs ARM MacOS.
BREW_PREFIX=$(brew --prefix | sed 's#/#\\\/#g')

SEMVER_MINOR_REGEX="^[0-9]+\.[0-9]+$"
SEMVER_PATCH_REGEX=^[0-9]+.[0-9]+.[0-9]+.*$

if [[ $1 =~ $SEMVER_PATCH_REGEX ]];
then
#  echo "PHP_PATCH: $1"
  PHP_PATCH=$1
  PHP_MINOR=$(sed -E -e 's/([0-9]+\.[0-9]+).*/\1/g' <<< $PHP_PATCH)
#  echo "PHP_MINOR: $PHP_MINOR"
  PHP_DIR=$(find $BREW_PREFIX/Cellar/php@$PHP_MINOR/$PHP_PATCH* -type d -maxdepth 0 | head -1)
  if [[ -z "$PHP_DIR" ]]; then
     echo "Is PHP $PHP_PATCH installed?"
     exit 0
  fi
  PHP_BIN=$PHP_DIR/bin/php
#  echo "PHP_BIN: $PHP_BIN"
  # Remove first argument from input.
  shift;
elif [[ $1 =~ $SEMVER_MINOR_REGEX ]];
then
#  echo "PHP_MINOR: $1"
  PHP_MINOR=$1
  # TODO: just get first result (HEAD)
  PHP_DIR=$(find $BREW_PREFIX/Cellar/php@$PHP_MINOR/$PHP_MINOR* -type d -maxdepth 0 | head -1)
  if [[ -z "$PHP_DIR" ]]; then
     echo "Is PHP $PHP_MINOR installed?"
     exit 0
  fi
#  echo "PHP_DIR: $PHP_DIR"
  PHP_BIN=$PHP_DIR/bin/php
#  echo "PHP_BIN: $PHP_BIN"
  # Remove first argument from input.
  shift;
else
  # PHP was not input, using current PHP version.
  PHP=$CURRENT_PHP
  echo "PHP was not input, using current PHP version: $PHP"
  PHP_BIN=$(which php)
#  echo "PHP_BIN: $PHP_BIN"
fi

echo "$PHP_BIN $(which composer) $@"
$PHP_BIN $(which composer) $@