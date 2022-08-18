
#!/bin/bash

# Copyright (C) 2020 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>

# secrets
DATABASE_USERNAME="postgres"
DATABASE_PASSWORD="$(openssl rand -hex 33)"
JWT_SECRET="$(openssl rand -hex 64)"
JWT_TIMEOUT="1d"
API_KEY_SECRET="$(openssl rand -hex 33)"

# Install heimdall
helm install heimdall . \
     -f values.yaml \
    --set   databaseUsername=$DATABASE_USERNAME \
    --set   databasePassword=$DATABASE_PASSWORD \
    --set   jwtSecret=$JWT_SECRET \
    --set   jwtTimeout=$JWT_TIMEOUT \
    --set   apiKeySecret=$API_KEY_SECRET 
