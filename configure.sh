# Rename app.default.php to app.php
# Create database for cake.
# Create Apache Vhost.

#! /bin/bash

# Set variables for MySQL.
passRoot=""
userCake="user_cake"
passCake="djhg4587g"
host="localhost"
databaseCake="cakephp"


# mysql -uroot -p$DB_PASSWORD -h$DB_1_PORT_3306_TCP_ADDR -P$DB_1_PORT_3306_TCP_PORT -e "SHOW DATABASES LIKE 'cakephp';" | grep "cakephp" > /dev/null; echo "$?"
dataBase=$(mysql -uroot -h$host -e "SHOW DATABASES LIKE 'cakephp';"| grep "$databaseCake" | awk '{print $2}';)

if [ "$dataBase" != "(cakephp)" ]; then
	mysql -uroot -h$host -e "CREATE DATABASE $databaseCake;"
	mysql -uroot -h$host -e "CREATE USER '$userCake'@'$host' IDENTIFIED BY '$passCake';"
	mysql -uroot -h$host -e "GRANT ALL PRIVILEGES ON $databaseCake.* TO '$userCake'@'$host';"
	mysql -uroot -h$host -e "FLUSH PRIVILEGES;";
	echo "=> Database and user created."
else
	echo "==> Database and user it already exists."
fi

rm -rf /etc/apache2/sites-available/
rm -f /etc/apache2/sites-enabled/000-default.conf
#service apache2 restart
# Apache
# Change Doc root.
#sed -i "s/\/var\/www\/html/\/var\/www\/html\/cakephp/g" /etc/apache2/sites-enabled/000-default.conf
