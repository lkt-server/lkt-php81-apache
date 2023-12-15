# LKT PHP 8.1 Apache

A pre-configured docker file, so you can have an apache php 8.1 server working in just five minutes.

## Included configuration:
- Apache2 mods: rewrite, deflate, ssl
- PDO, PDO MySQL, mysqli, mariadb-client
- Zip
- Intl
- LDAP
- IMAP
- XML
- GD
- Imagick
- Composer
- Optional SSL config

## Installation
Simply clone this repo.

## Build the image
Move to this directory and type in a terminal:

```shell
sudo docker build -t lkt-php81-apache:latest .

# Force clean composer install
sudo docker build --no-cache -t lkt-php81-apache:latest .
```

## Launch a container
```shell
sudo docker run -d -p 80:80 --name lkt-php81-apache lkt-php81-apache:latest
```

## Open container terminal
```shell
sudo docker exec -ti lkt-php81-apache bash
```

## Stop
```shell
sudo docker stop lkt-php81-apache
```

## Remove
```shell
sudo docker rm lkt-php81-apache
```

## Run composer commands
```bash
sudo docker exec -t lkt-php81-apache composer
sudo docker exec -t lkt-php81-apache composer update
```
