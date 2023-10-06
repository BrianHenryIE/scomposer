# scomposer

PHP switcher for running Composer

If you have multiple PHP versions installed via Hombrew, `brew install shivammathur/php/php@8.1`, this script allows calling `composer` with any of them.

## Use

```bash
scomposer 7.4 update
```

## Install

```bash
curl -L https://raw.githubusercontent.com/brianhenryie/scomposer/master/scomposer.sh > $(brew --prefix)/bin/scomposer
chmod +x $(brew --prefix)/bin/scomposer
```

Uninstall: `rm $(brew --prefix)/bin/scomposer`

## E.g

```bash
% php -v
PHP 8.1.23 (cli) (built: Sep  1 2023 00:30:14) (NTS)
Copyright (c) The PHP Group
Zend Engine v4.1.23, Copyright (c) Zend Technologies
    with Zend OPcache v8.1.23, Copyright (c), by Zend Technologies
    with Xdebug v3.2.2, Copyright (c) 2002-2023, by Derick Rethans

% scomposer 7.4 update
/opt/homebrew/Cellar/php@7.4/7.4.33_4/bin/php /opt/homebrew/bin/composer update
Gathering patches for root package.
...
```

## Acknowledgements

The great PHP/Apache/MariaDB/Xdebug/etc. install guide at:

https://getgrav.org/blog/macos-ventura-apache-multiple-php-versions