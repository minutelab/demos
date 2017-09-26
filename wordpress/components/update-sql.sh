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

# extruct siteurl
siteurl="$(mysql -h db --user=root --password=example wordpress -e "select option_value from wp_options where option_name='siteurl';")" || err=$?
if [ "$err" -eq 1 ]
then
	echo "DB is not initielized"
else
	wp plugin install "WP migrate DB"
	wp plugin activate "wp-migrate-db"
	prev="${siteurl#*http://}"
	echo prev:$prev
	echo curr:$curr
	wp migratedb find-replace --find=$prev --replace=$curr --skip-replace-guids
	wp plugin deactivate "wp-migrate-db"
	wp plugin delete "wp-migrate-db"
fi
