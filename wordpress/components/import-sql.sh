#!/bin/bash

set -e

while getopts p: opt
do
	case $opt in
		p) curr="$OPTARG" ;;
		?) echo "unhandled option: $opt"
		   exit 1
		   ;;
	esac
done

shift $((OPTIND-1))

# import db
mysql -h db --user=root --password=example wordpress < /import/*.sql

# extruct siteurl
siteurl="$(mysql -h db --user=root --password=example wordpress -e "select option_value from wp_options where option_name='siteurl';")"

wp plugin install "WP migrate DB"
wp plugin activate "wp-migrate-db"
prev="${siteurl#*http://}"
echo prev:$prev
echo curr:127.0.0.1:$curr
wp migratedb find-replace --find=$prev --replace=127.0.0.1:$curr --skip-replace-guids
wp plugin deactivate "wp-migrate-db"
wp plugin delete "wp-migrate-db"
