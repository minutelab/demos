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
mysql -h db --user=root --password=example wordpress < /wp-share/*.sql

$(dirname "$0")/update-sql.sh -p$curr
