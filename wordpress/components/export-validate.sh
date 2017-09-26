#!/bin/sh

set -e

while getopts m:u: opt
do
	case $opt in
		m) migrate="$OPTARG" ;;
    u) URL="$OPTARG" ;;
		?) echo "unhandled option: $opt"
		   exit 1
		   ;;
	esac
done

if [ "$migrate" = true ]
then
  if [ -z "$URL" ]
  then
    echo ERROR: Must specify new URL if DB migration required
    exit 1
  fi
fi

if [ $migrate = false ]
then
  if [ ! -z "$URL" ]
  then
    echo ERROR: URL \($URL\) must be empty if DB migration is not required
    exit 1
  fi
fi
