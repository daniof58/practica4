#!/bin/bash

# Importamos las variables del archivo .env
source .env

# Modo de depuración
set -ex

# Crear el certificado SSL/TLS autofirmado
sudo openssl req \
  -x509 \
  -nodes \
  -days 365 \
  -newkey rsa:2048 \
  -keyout /etc/ssl/private/apache-selfsigned.key \
  -out /etc/ssl/certs/apache-selfsigned.crt \
  -subj "/C=$OPENSSL_COUNTRY/ST=$OPENSSL_PROVINCE/L=$OPENSSL_LOCALITY/O=$OPENSSL_ORGANIZATION/OU=$OPENSSL_ORGUNIT/CN=$OPENSSL_COMMON_NAME/emailAddress=$OPENSSL_EMAIL"

# Copiar archivo de configuración SSL para Apache
cp ../conf/default-ssl.conf /etc/apache2/sites-available

# Habilitar el sitio SSL en Apache
sudo a2ensite default-ssl.conf

# Habilitar el módulo SSL en Apache
sudo a2enmod ssl

# Copiar archivo de configuración HTTP para Apache
cp ../conf/000-default.conf /etc/apache2/sites-available

# Habilitar el sitio HTTP en Apache
a2ensite 000-default.conf

# Habilitar módulo de reescritura en Apache
sudo a2enmod rewrite

# Reiniciar Apache para aplicar cambios
systemctl restart apache2