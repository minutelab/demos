#!/bin/bash

rm -r /var/www/html/wp-content/themes/*
rm -r /var/www/html/wp-content/plugins/*
rm -r /var/www/html/wp-content/uploads/*

cd /wp-share/wp-content
tar cf - . |  tar -C /var/www/html/wp-content -xBf -
