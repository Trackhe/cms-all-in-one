#Download base image
FROM debian:latest

#Update & upgrade
RUN apt-get update && apt-get upgrade -y
#Install Essential Items.
RUN apt-get -y install lsb-release apt-transport-https ca-certificates wget expect unzip

#Install PHP
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

#Update Lists again.
RUN apt-get update && apt-get -y install php \
    #Need to be Manual Update!
    php7.4-mysqli \
    php7.4-mysql \
    php7.4-mbstring

RUN /bin/sh && /bin/bash && apt-get -y install mariadb-server

RUN /bin/bash && cd /var/www/html && mkdir dev && chown www-data:www-data dev && echo "<?php phpinfo(); ?>" > info.php && \
    wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip && unzip phpMyAdmin-latest-all-languages.zip && rm phpMyAdmin-l* && mv phpMyAdmin-* phpmyadmin && \
    cd phpmyadmin && mkdir tmp && chmod 777 tmp && echo '<?php $cfg["blowfish_secret"] = "n6yFA4oP9orT31jAwNYJxJIKCpgbqUsi"; $cfg["TempDir"] = "tmp"; ?>' > config.inc.php && \
    cd /etc/apache2/sites-enabled && rm 000-default.conf && \
    echo "<VirtualHost *:80>" > 000-default.conf && \
    echo "ServerName localhost" >> 000-default.conf && \
    echo "ServerAdmin webmaster@localhost" >> 000-default.conf && \
    echo "DocumentRoot /var/www/html" >> 000-default.conf && \
    echo "</VirtualHost>" >> 000-default.conf && \
    cd /etc/apache2 && echo "ServerName localhost" >> apache2.conf


#start serivces
CMD service apache2 start && service mysql start && mysql -u root -e "CREATE USER IF NOT EXISTS'admin'@'%' IDENTIFIED BY 'admin';" && mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY 'admin'; FLUSH PRIVILEGES;" && /bin/bash && tail -f /dev/null
#Open PORTS
EXPOSE 80 443
VOLUME /var/www/html/dev
