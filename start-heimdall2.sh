
#!/bin/bash

# Copyright (C) 2020 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>

source .env

# secrets
DATABASE_USERNAME="postgres"
DATABASE_PASSWORD="$(openssl rand -hex 33)"
JWT_SECRET="$(openssl rand -hex 64)"
JWT_TIMEOUT="1d"
API_KEY_SECRET="$(openssl rand -hex 33)"
NAMESPACE="heimdall"

# Install heimdall
helm install heimdall heimdall2 \
    -n $NAMESPACE --create-namespace \
    -f values.yaml \
    --set   databaseUsername=$DATABASE_USERNAME \
    --set   databasePassword=$DATABASE_PASSWORD \
    --set   jwtSecret=$JWT_SECRET \
    --set   jwtTimeout=$JWT_TIMEOUT \
    --set   apiKeySecret=$API_KEY_SECRET \
    --set   oidcName=$OIDC_NAME \
    --set   oidcExternalUrl=$EXTERNAL_URL \
    --set   oidcIssuer=$OIDC_ISSUER \
    --set   oidcAuthorizationUrl=$OIDC_AUTHORIZATION_URL \
    --set   oidcTokenUrl=$OIDC_TOKEN_URL \
    --set   oidcUserInfoUrl=$OIDC_USER_INFO_URL \
    --set   oidcClientId=$OIDC_CLIENTID \
    --set   oidcClientSecret=$OIDC_CLIENT_SECRET \
    --set   externalUrl=$EXTERNAL_URL
