#!/bin/bash

php /var/www/html/occ config:system:set trusted_domains 10 --value=nextcloud

# Disable throttling for dev — mobile login retries trip the default
# brute-force protection and rate limiter, blocking further requests.
php /var/www/html/occ config:system:set auth.bruteforce.protection.enabled --value=false --type=boolean
php /var/www/html/occ config:system:set ratelimit.protection.enabled --value=false --type=boolean

# Remove stock onlyoffice app if present — it conflicts with elixiroffice's autoloader
rm -rf /var/www/html/custom_apps/onlyoffice

echo "Waiting for ElixirOffice document server to be ready..."
until curl -sf http://eo/healthcheck > /dev/null 2>&1; do
    echo "Waiting for http://eo/healthcheck..."
    sleep 5
done
echo "Document server is ready!"

# Baseline URL; `make local` / `make mobile` rewrite this via `refresh-urls`.
php /var/www/html/occ app:enable elixiroffice
php /var/www/html/occ config:app:set elixiroffice DocumentServerUrl --value="http://localhost:8080/"
php /var/www/html/occ config:app:set elixiroffice StorageUrl --value="http://nextcloud/"
php /var/www/html/occ config:app:set elixiroffice DocumentServerInternalUrl --value="http://eo/"
php /var/www/html/occ config:app:set elixiroffice VerifyPeerOff --value="true"
php /var/www/html/occ config:app:set elixiroffice jwt_secret --value="elixiroffice-dev-jwt-secret-key-2026"

