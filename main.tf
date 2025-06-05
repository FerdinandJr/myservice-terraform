provider "aws" {
  region = "ap-southeast-1"
}

# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get default subnets in the default VPC (we use 2 for RDS subnet group)
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Create a security group in the default VPC
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow SSH and MySQL"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # or restrict to your VPC's CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch EC2 instance in the first default subnet
resource "aws_instance" "ec2" {
  ami                         = "ami-069cb3204f7a90763" # Ubuntu in ap-southeast-1
  instance_type               = "t2.micro"
  subnet_id                   = data.aws_subnets.default.ids[0]
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Terraform-EC2"
  }
}

# RDS subnet group using at least 2 default subnets in different AZs
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "rds-default-subnet-group"
  subnet_ids = [data.aws_subnets.default.ids[0], data.aws_subnets.default.ids[1]]

  tags = {
    Name = "RDS subnet group"
  }
}

#data source to look up a secret in AWS Secrets Manager by name.
data "aws_secretsmanager_secret" "rds" {
  name = "rds/mysql/creds"
}

#This fetches the current version of the secret, including its actual value.
data "aws_secretsmanager_secret_version" "rds" {
  secret_id = data.aws_secretsmanager_secret.rds.id
}

#This takes the JSON-formatted string stored in Secrets Manager
locals {
  db_credentials = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)
}

# RDS instance in default VPC
resource "aws_db_instance" "rds" {
  allocated_storage       = 20
  engine                  = "mysql"
  instance_class          = "db.t4g.micro"
  username                = local.db_credentials.username
  password                = local.db_credentials.password
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.ec2_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = false
}