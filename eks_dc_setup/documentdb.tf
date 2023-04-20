
# DocDB Subnet Group
resource "aws_docdb_subnet_group" "example_docdb_subnet_group" {
  name       = "${var.cluster_name}-docdb-subnet-group"
  subnet_ids = module.vpc.database_subnets
}

# DocDB Cluster
resource "aws_docdb_cluster" "example_docdb_cluster" {
  cluster_identifier   = "${var.cluster_name}-docdb-cluster"
  engine       = "docdb"
  master_username = "docadmin"
  master_password = "password"
  db_subnet_group_name = aws_docdb_subnet_group.example_docdb_subnet_group.name
  vpc_security_group_ids = [aws_security_group.docdb_sg.id]

  skip_final_snapshot = true
}

# DocDB Instance
resource "aws_docdb_cluster_instance" "example_docdb_instance" {
  count                   = 1
  cluster_identifier      = aws_docdb_cluster.example_docdb_cluster.id
  instance_class          = "db.t3.medium"
  identifier              = "${var.cluster_name}-docdb-instance-${count.index}"
  apply_immediately       = true
}
