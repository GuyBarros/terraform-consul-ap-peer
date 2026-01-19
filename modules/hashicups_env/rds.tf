################################################################################
# AWS Lambda definition
################################################################################

module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.2.0"

  function_name = "product-db-init"
  description   = "HashiCups DB initialization"
  handler       = "product-db-init.lambda_handler"
  runtime       = "python3.9"

  source_path = "./config/lambda-function"

  environment_variables = {
    DB_HOST     = aws_db_instance.database.address
    DB_PORT     = 5432
    DB_NAME     = aws_db_instance.database.db_name
    DB_USER     = aws_db_instance.database.username
    DB_PASSWORD = aws_db_instance.database.password
  }

  vpc_subnet_ids         = module.vpc.public_subnets
  vpc_security_group_ids = [module.security_group.security_group_id]
  attach_network_policy  = true
  timeout                = 120

  depends_on = [aws_db_instance.database]
}

################################################################################
# AWS Lambda invokation
################################################################################

resource "aws_lambda_invocation" "database_init" {
  function_name = module.lambda_function.lambda_function_name

  input = jsonencode({
    key = "db-init"
  })

  depends_on = [module.lambda_function]
}

output "aws_lambda_result" {
  value = jsondecode(aws_lambda_invocation.database_init.result)
}

################################################################################

data "aws_db_instance" "database" {
  db_instance_identifier = aws_db_instance.database.identifier
}

################################################################################
# AWS RDS
################################################################################
resource "aws_db_subnet_group" "hashicups" {
  name       = "hashicups"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "hashicups"
  }
}

resource "aws_db_instance" "database" {
  identifier          = var.cluster_name
  allocated_storage   = 6
  engine              = "postgres"
  engine_version      = "17.4"
  instance_class      = "db.m5d.large"
  db_name             = "products"
  username            = "postgres"
  password            = "password"
  port                = 5432
  skip_final_snapshot = true
  multi_az            = false
  publicly_accessible = true

  db_subnet_group_name = aws_db_subnet_group.hashicups.name

  vpc_security_group_ids = [module.security_group.security_group_id,aws_security_group.node_group_one.id]

  depends_on = [module.vpc, module.security_group]
}

################################################################################
# Supporting Resources
################################################################################

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = var.cluster_name
  description = "PostgreSQL security group"
  vpc_id      = module.vpc.vpc_id

  # ingress only - no egress traffic defined
  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "PostgreSQL access from within VPC"
      #cidr_blocks = module.vpc.vpc_cidr_block
      cidr_blocks = "0.0.0.0/0"
    
    },
  ]
}

################################################################################
# Outputs
################################################################################

output "aws_rds_endpoint" {
  value = data.aws_db_instance.database.address
}