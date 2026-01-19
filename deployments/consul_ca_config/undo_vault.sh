# #these you need to add manually
# export VAULT_ADDR=
# export VAULT_NAMESPACE=
# export VAULT_TOKEN=

vault policy delete dc1 
vault policy delete ap1 
vault policy delete dc2 

vault token delete $DC1_VAULT_TOKEN
vault token delete $AP1_VAULT_TOKEN
vault token delete $DC2_VAULT_TOKEN 

vault secrets disable -path=connect_root
vault secrets disable -path=connect_dc1_inter
vault secrets disable -path=connect_dc2_inter