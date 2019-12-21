# cms-all-in-one
Docker Image Ideal for dev cms designs plugins php usw.

#Installed PHP over
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

Installed php 7.4
    php7.4-mysqli \
    php7.4-mysql \
    php7.4-mbstring

#Installed Packages
  lsb-release
  apt-transport-https
  ca-certificates
  wget
  expect
  unzip
  mariadb-server

Installed is PHPmyadmin. use port 80 default. and path localhost/phpmyadmin
$cfg["blowfish_secret"] = "n6yFA4oP9orT31jAwNYJxJIKCpgbqUsi"; is already set.

    cd /etc/apache2/sites-enabled && rm 000-default.conf && \
    echo "<VirtualHost *:80>" > 000-default.conf && \
    echo "ServerName localhost" >> 000-default.conf && \
    echo "ServerAdmin webmaster@localhost" >> 000-default.conf && \
    echo "DocumentRoot /var/www/html" >> 000-default.conf && \
    echo "</VirtualHost>" >> 000-default.conf && \
    cd /etc/apache2 && echo "ServerName localhost" >> apache2.conf

Default the image make eavery restart an admin user is it dosent exist.

i hope you enjoy it. And i love Pull requests.
