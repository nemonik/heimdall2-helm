# heimdall2-helm

A helm chart for Heimdall2 project found at [https://github.com/mitre/heimdall2](https://github.com/mitre/heimdall2).

## Requirements

Written for Helm 3.

## Example use

You can clone this repo, enter the repository folder and then execute something like the [start_heimdall2.sh](start_heimdall2.sh):

```
./start_heimdal2.sh
```

The script will spin up Heimdall2 using the example [example_values.yaml](example_values.yaml) values file.  You will need
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

## To install via my chart repository

```
helm repo add nemonik https://nemonik.github.io/helm-charts/
helm repo update
helm search repo heimdall2
wget https://raw.githubusercontent.com/nemonik/heimdall2-helm/master/example-values.yaml
helm install heimdall2 nemonik/heimdall2 --namespace heimdall2 --create-namespace -f example-values.yaml
watch -n 15 kubectl get pods -n heimdall2
```

Give it time for Heimdall2 to come fully up.  It has to "migrate" data...  It takes a while.

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

In my forthcoming updated Hands-on DevOps class I do this exposing Heimdall2 over https, so when that
drops you can find some insight how to do so there.

## License

3-Clause BSD License

## Author Information

Michael Joseph Walsh <mjwalsh@nemonik.com>
