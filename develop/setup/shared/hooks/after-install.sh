#!/bin/bash
set -e

# Disable dev-unfriendly protections
occ config:system:set auth.bruteforce.protection.enabled --value=false --type=boolean
occ config:system:set ratelimit.protection.enabled --value=false --type=boolean

# Allow eo to call back to NC via the service hostname
occ config:system:set trusted_domains 3 --value=nextcloud

# Remove stock onlyoffice if present — conflicts with elixiroffice autoloader
rm -rf /var/www/html/custom_apps/onlyoffice

echo "Waiting for ElixirOffice document server to be ready..."
until curl -sf http://eo/healthcheck > /dev/null 2>&1; do
    echo "  still waiting..."
    sleep 5
done
echo "Document server ready."

occ app:enable elixiroffice
occ config:app:set elixiroffice DocumentServerUrl         --value="http://localhost:8080/"
occ config:app:set elixiroffice StorageUrl               --value="http://nextcloud/"
occ config:app:set elixiroffice DocumentServerInternalUrl --value="http://eo/"
occ config:app:set elixiroffice VerifyPeerOff            --value="true"
occ config:app:set elixiroffice jwt_secret               --value="${EO_JWT_SECRET:-elixiroffice-dev-jwt-secret-key-2026}"
