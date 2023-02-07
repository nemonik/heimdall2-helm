# heimdall2-helm

A helm chart for Heimdall2 project found at [https://github.com/mitre/heimdall2](https://github.com/mitre/heimdall2).

## Requirements

Written for Helm 3.

## Example use

You can clone this repo, enter the repository folder and then execute something like the [start_heimdall2.sh](start_heimdall2.sh):

```
./start_heimdal2.sh
```

The script will spin up Heimdall2 using the example [values.yaml](values.yaml) values file.  You will need
to provide your own if you want to configure other settings, and ingress, etc.  Look at the [values.yaml](values.yaml)
file for what to place in your own.

To generate the postgres user's password consider using

```bash
openssl rand -hex 33
``` 

And to to generate a value for JWS_SECRET consider using 

```bash
openssl rand -hex 64
```

The start_heimdall.sh script generates some of these values for you, and demonstrates how to pass in values from the cli instead of using the values.yaml file via the `--set` flag.

## To install via MITRE chart repository

```
helm repo add nemonik https://mitre.github.io/heimdall2-helm/
helm repo update
helm search repo heimdall2
wget https://raw.githubusercontent.com/mitre/heimdall2-helm/master/values.yaml
vi values.yaml # configure values.yaml for your organization
helm install heimdall heimdall2-helm/heimdall --namespace heimdall --create-namespace -f values.yaml
watch -n 15 kubectl get pods -n heimdall2
```

Give it time for Heimdall2 to come fully up.  It has to "migrate" data, and the frontend site needs to build. It takes a few minutes.

## Accessing Heimdall2

If you've spun up Heimdall2 using the [start_heimdall2.sh](start_heimdall2.sh) script, you can access it in your
browser via exposing via `kubectl port-forward` like so

```
kubectl port-forward -n heimdall service/heimdall2 8081:80
```

then open in your browser [http://localhost:8081(http://localhost:8081)

Or configure an ingress via your values file by adding an `ingress` configuration under
`heimdall` in your values file likes so:

```
heimdall:
  ingress:
    enabled: true
    annotations:
      traefik.ingress.kubernetes.io/router.entrypoints: web
    hosts:
      - host: heimdall.example.com
        paths:
          -  "/"
    tls: []
``` 

This example uses Traefik to expose the ingress.  Configuring Traefik is out of scope of this 
readme.  


## License

3-Clause BSD License

## Author Information

Michael Joseph Walsh <mjwalsh@nemonik.com>
MITRE SAF team <saf@groups.mitre.org>
