#!/bin/bash

set -e

while getopts mp: opt
do
	case $opt in
		p) curr="$OPTARG" ;;
    m) migrate=1 ;;
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
  exit 0
fi

if [ "$migrate" -eq 1 ]
then
  wp plugin is-installed "wp-migrate-db" || installed=$?
  if [ "$installed" -eq 1 ]
  then
    wp plugin install "WP migrate DB"
	  wp plugin activate "wp-migrate-db"
  fi

  prev="${siteurl#*127.0.0.1:}"
  echo prev:$prev
  echo curr:$curr
  wp migratedb export export --find=127.0.0.1:$prev --replace=$curr --skip-replace-guids

  if [ "$installed" -eq 1 ]
  then
    wp plugin deactivate "wp-migrate-db"
	  wp plugin delete "wp-migrate-db"
  fi
else
  wp db export export.sql
fi

mv ./export.sql /wp-share/
