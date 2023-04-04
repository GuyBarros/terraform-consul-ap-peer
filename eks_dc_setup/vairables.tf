variable "instance_count" {
  type    = string
  default = "1"
}

variable "region" {
  default     = "eu-west-2"
  description = "AWS region"
}

variable "cluster_name" {
  default     = "cluster1" 
  description = "the cluster name you want to give to this cluster, making it numerical hels i.e. cluster1"
}


variable "documentdb_master_username" {
  description = "Username that will be used to create the AWS Postgres instance"
  default     = "docadmin"
}

variable "documentdb_master__password" {
  description = "Password that will be used to create the AWS Postgres instance"
  default     = "YourPwdShouldBeLongAndSecure!"
}