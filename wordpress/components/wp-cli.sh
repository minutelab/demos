#!/bin/bash

set -e

apt-get install -y sudo less mysql-client curl
rm -rf /var/lib/apt/lists/*

curl -o /bin/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x /bin/wp-cli.phar

echo "#!/bin/sh" > /bin/wp
echo "# This is a wrapper so that wp-cli can run as the www-data user so that permissions" >> /bin/wp
echo "# remain correct" >> /bin/wp
echo "sudo -u www-data /bin/wp-cli.phar \"\$@\"" >> /bin/wp

chmod +x /bin/wp
