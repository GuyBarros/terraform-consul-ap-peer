# https://developer.hashicorp.com/consul/tutorials/operate-consul/vault-pki-consul-connect-ca 
## these are added from 0_install_consul.sh outputs
# export DC1_CONSUL_HTTP_ADDR=
# export DC1_CONSUL_HTTP_TOKEN=
# export DC2_CONSUL_HTTP_ADDR=
# export DC2_CONSUL_HTTP_TOKEN=
# #these you need to add manually
# export VAULT_ADDR=
# export VAULT_NAMESPACE=
# export VAULT_TOKEN=

export CONSUL_HTTP_SSL_VERIFY=false

vault policy write dc1 ./deployments/consul_ca_config/dc1.hcl
vault policy write ap1 ./deployments/consul_ca_config/ap1.hcl
vault policy write dc2 ./deployments/consul_ca_config/dc2.hcl

DC1_VAULT_TOKEN=$(vault token create -policy=dc1 -policy=default -format=json | jq -r .auth.client_token)
AP1_VAULT_TOKEN=$(vault token create -policy=ap1 -policy=default -format=json | jq -r .auth.client_token)
DC2_VAULT_TOKEN=$(vault token create -policy=dc2 -policy=default -format=json | jq -r .auth.client_token)

#configure DC1 CA Config in Consul
#check existing config
curl -k --header "X-Consul-Token: ${DC1_CONSUL_HTTP_TOKEN}" \
    ${DC1_CONSUL_HTTP_ADDR}/v1/connect/ca/configuration

#config with Vault info
curl -ks \
  --header "X-Consul-Token: ${DC1_CONSUL_HTTP_TOKEN}" \
  --request PUT \
  --data @./deployments/consul_ca_config/dc1-ca-config.json \
${DC1_CONSUL_HTTP_ADDR}/v1/connect/ca/configuration

#check update config
curl -k --header "X-Consul-Token: ${DC1_CONSUL_HTTP_TOKEN}" \
    ${DC1_CONSUL_HTTP_ADDR}/v1/connect/ca/configuration


#do the same in DC2
#check existing config
curl -k --header "X-Consul-Token: ${DC2_CONSUL_HTTP_TOKEN}" \
    ${DC2_CONSUL_HTTP_ADDR}/v1/connect/ca/configuration

#config with Vault info
curl -ks \
  --header "X-Consul-Token: ${DC2_CONSUL_HTTP_TOKEN}" \
  --request PUT \
  --data @./deployments/consul_ca_config/dc2-ca-config.json \
${DC2_CONSUL_HTTP_ADDR}/v1/connect/ca/configuration

#check update config
curl -k --header "X-Consul-Token: ${DC2_CONSUL_HTTP_TOKEN}" \
    ${DC2_CONSUL_HTTP_ADDR}/v1/connect/ca/configuration
# consul connect ca set-config -config-file ./deployments/consul_ca_config/dc1-ca-config.json
# consul connect ca set-config -config-file ./deployments/consul_ca_config/ap1-ca-config.json
# consul connect ca set-config -config-file ./deployments/consul_ca_config/dc2-ca-config.json