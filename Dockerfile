#FROM ponchov/cake
FROM whatwedo/apache-php56

RUN apt-get update && apt-get install -y php5-intl php5-cli supervisor php5-mbstring libapache2-mod-php5
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-client mysql-server openssh-client openssh-server

RUN mkdir -p /var/www/html
RUN curl -s https://getcomposer.org/installer | php && php composer.phar create-project --prefer-dist cakephp/app /var/www/html/cakephp
#COPY  cakephp /var/www/html/cakephp
COPY app.php /var/www/html/cakephp/config/
RUN chown www-data:www-data /var/www/html/ -R

EXPOSE 80
EXPOSE 3306

RUN a2enmod rewrite

RUN rm -f /etc/apache2/sites-enabled/000-default.conf
COPY cakephp.conf /etc/apache2/sites-enabled/cakephp.conf
COPY configure.sh /configure.sh
RUN chmod +x /configure.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
