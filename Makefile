all: login init demostack apply
.PHONY: all doormat_creds doormat_aws deploy destroy console
TFC_ORG = emea-se-playground-2019
DOORMAT_AWS_CLOUD =  aws_guy_test
login:
	doormat login
init:
	terraform init
demostack:
	doormat aws --account $(DOORMAT_AWS_CLOUD) 
apply:
	terraform init
	terraform plan
	terraform apply
destroy:
	terraform destroy