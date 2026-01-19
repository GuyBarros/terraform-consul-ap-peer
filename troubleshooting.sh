export CONSUL_HTTP_ADDR=
export CONSUL_HTTP_TOKEN=
export CONSUL_HTTP_SSL_VERIFY=false

consul config read -kind sameness-group -name hashicups

consul config list -kind exported-services

consul config list -kind imported-services

consul catalog services -peer=<peer-name> 

consul intention list