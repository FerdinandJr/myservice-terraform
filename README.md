# Setting Up Terraform Remote Backend with AWS S3

![terraform-backend-s3](https://github.com/FerdinandJr/terraform-backend-s3-dynamodb/blob/27f2b92f0d2a93edfbf4c0434af0994e6767f100/terraform-backend-s3-dynamodb.svg)

## Create an IAM Policy for Terraform
To allow Terraform to access the required AWS resources, create an IAM policy with the following permissions:

### Attach the Policy to the IAM User
Go to IAM > Users in the AWS Console.

1. Select your user (e.g., terraform-user).

2. Navigate to the Permissions tab.

3. Click Add permissions > Attach policies directly.

4. Click Create policy, switch to the JSON tab, and paste the policy above.

5. Name it: TerraformStateAccessPolicy.

6. Create and attach it to the user.

## Set Up the Backend in Terraform

### Create S3 Bucket
Used to store the remote Terraform state file.

## Configure the Terraform Backend

```bash
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-321"          # Name of the S3 bucket to store the state file
    key            = "envs/prod/terraform.tfstate"     # Path within the S3 bucket (state file location)
    region         = "ap-southeast-1"                  # AWS region where the S3 bucket and DynamoDB table are hosted
    use_lockfile   = true                              # ✅ Native S3-based state locking!
    encrypt        = true                              # Enable server-side encryption for the state file
  }
}
```

## Initialize the Backend

```bash
terraform init
```
