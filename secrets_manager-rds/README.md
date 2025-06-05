# Using AWS Secrets Manager with Terraform to Store RDS Credentials

![terraform-backend-s3](terraform-backend-s3.svg)

## Create a Secret in AWS Secrets Manager

### You can also store secrets in JSON format if there are multiple values:

```bash
{
  "username": "sampleuser",
  "password": "samplepassword"
}
```

## Terraform Code Example

```bash
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
```

## Initialize and Apply Terraform

```bash
terraform apply
```
