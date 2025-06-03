# Setting Up Terraform Remote Backend with AWS S3 and DynamoDB

## Create an IAM Policy for Terraform
To allow Terraform to access the required AWS resources, create an IAM policy with the following permissions:

```bash
TerraformStateAccessPolicy File Attached
```

## Attach the Policy to the IAM User
Go to IAM > Users in the AWS Console.

Select your user (e.g., terraform-user).

Navigate to the Permissions tab.

Click Add permissions > Attach policies directly.

Click Create policy, switch to the JSON tab, and paste the policy above.

Name it: TerraformStateAccessPolicy.

Create and attach it to the user.

## Set Up the Backend in Terraform

### Create S3 Bucket
Used to store the remote Terraform state file.

### Create DynamoDB Table
Used to handle state locking. Make sure the table includes a primary key attribute called LockID.

## Configure the Terraform Backend

```bash
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-321"
    key            = "envs/prod/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

## Initialize the Backend

```bash
terraform init
```