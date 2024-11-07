#!/bin/bash

# Muestra cada comando y notifica si ocurre un error
set -ex

# Actualización de los repositorios
apt update

# Actualización de los paquetes
apt upgrade -y

# Instalación de Apache
apt install apache2 -y

# Eliminación de paquetes innecesarios
apt purge

# Habilitación del módulo rewrite de Apache
a2enmod rewrite

# Copia del archivo de configuración personalizado de Apache
cp ../conf/000-default.conf /etc/apache2/sites-available

# Instalación de PHP y módulos para Apache y MySQL
apt install php libapache2-mod-php php-mysql -y

# Reinicio del servicio de Apache
systemctl restart apache2

# Instalación de MySQL
apt install mysql-server -y

# Copia del archivo de prueba PHP a la carpeta de Apache
cp ../php/index.php /var/www/html

# Cambio de propietario y grupo para el archivo index.php
chown -R www-data:www-data /var/www/html