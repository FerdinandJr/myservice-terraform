# Terraform: Install and Create My First Infrastructure

[![terraform_three_tier_architecture](https://img.youtube.com/vi/QTXNUg4UYhI/0.jpg)](https://www.youtube.com/watch?v=QTXNUg4UYhI)

## Table of Contents
- [Install Terraform and AWS CLI in Windows](#install-terraform-and-aws-cli-in-windows)
- [Install Terraform and AWS CLI in Linux](#install-terraform-and-aws-cli-in-linux)
- [Configure AWS CLI](#configure-aws-cli)
- [Video](#video)

## Install Terraform and AWS CLI in Windows
1. Open PowerShell as Administrator:

```bash
Press Press Windows + X and select Windows PowerShell (Admin) or Command Prompt (Admin)
```

2. Install Chocolatey:

```bash
Set-ExecutionPolicy Bypass -Scope Process -Force; 
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

3. Verify Installation:

```bash
choco --version
```

4. To install Terraform:

```bash
choco install terraform
```

5. To install AWS CLI:

```bash
choco install awscli
```

## Install Terraform and AWS CLI in Linux
#### First, download the AWS CLI installer package
1. Download the AWS CLI installer package:

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```

2. Unzip the downloaded package:

```bash
unzip awscliv2.zip
```

3. Run the installation script:

```bash
sudo ./aws/install
```

4. Verify AWS CLI Installation: 

```bash
aws --version
```
#### Second, Install Terraform on Linux
5. Open your terminal and run the following commands to install the required packages and add HashiCorp's repository:

```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
sudo apt-get install -y curl
```

6. Then, add HashiCorp’s official GPG key and repository:

```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
sudo apt-add-repository "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```

7. Once the repository is added, update your package list and install Terraform:

```bash
sudo apt-get update
sudo apt-get install terraform
```

8. Verify Installation

```bash
terraform -v
```

## Configure AWS CLI

1. Run the aws configure command

```bash
aws configure
```

2. Enter your AWS credentials when prompted:

```bash
AWS Access Key ID [None]: 
AWS Secret Access Key [None]: 
Default region name [None]: ap-southeast-1
Default output format [None]: 
```


## Generate Public key

```bash
ssh-keygen -t rsa -b 4096 -C "example comment"
```

## Video
## https://www.youtube.com/watch?v=ZP_vAbjfFMs
