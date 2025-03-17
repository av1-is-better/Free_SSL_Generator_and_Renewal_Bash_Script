#!/bin/bash

if [[ $(whoami) == "root"  ]];
then
	echo "==========================="
        echo "       SSL GENERATOR       "
	echo "==========================="
else
	echo "Please Run as Root User."
	exit 1
fi

echo ""

# Domain for which the SSL certificate will be generated
# Make sure this domain points to the host machine's static public ip 
# port 80 and 443 must be open and accessible
# do not use wildcard domain (always use sub domain)
DOMAIN="domain.example.com" 

# Email used for registration and recovery contact
EMAIL="your-email@gmail.com"

PASS="any-password-for-your-ssl-certificate" # can be used with pfx cert

# Generate a new certificate using the standalone plugin
# The standalone plugin requires that no other service is using port 80 or 443
sudo certbot certonly --standalone --preferred-challenges http --agree-tos --no-eff-email --email $EMAIL -d $DOMAIN --rsa-key-size 2048 --keep-until-expiring

# Concatenate private key and certificate into a single PEM file
sudo cat /etc/letsencrypt/live/$DOMAIN/privkey.pem /etc/letsencrypt/live/$DOMAIN/cert.pem > /etc/letsencrypt/live/$DOMAIN/combined.pem

# Generate a PFX file from the private key and certificate
sudo openssl pkcs12 -export -out /etc/letsencrypt/live/$DOMAIN/cert.pfx -inkey /etc/letsencrypt/live/$DOMAIN/privkey.pem -in /etc/letsencrypt/live/$DOMAIN/cert.pem -name $DOMAIN -passout pass:"${PASS}"

sudo chmod -R 777 /etc/letsencrypt/live/$DOMAIN/cert.pfx

echo -e "\n=========================="
echo -e "        COMPLETED         "
echo -e "==========================\n"

echo "Cert Directory: /etc/letsencrypt/live/${DOMAIN}"