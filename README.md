# Terraform AWS VPC Deployment

This project sets up an AWS VPC using a Terraform module. The configuration includes the creation of both public and private subnets across multiple availability zones. The setup is designed to deploy in a specific AWS region.

## Table of Contents

- [Terraform Cloud](#terraform-cloud)
- [Prerequisites](#prerequisites)
- [Module Configuration](#module-configuration)
- [Variables](#variables)
- [Providers](#providers)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [License](#license)

## Terraform Cloud

The Terraform configuration is set up to run in Terraform Cloud.

```hcl
terraform {
  cloud {
    organization = "sammielas"

    workspaces {
      name = "devops_aws_my_dev"
    }
  }
}
```

The workspace `devops_aws_my_dev` is used for managing this infrastructure within the `sammielas` organization on Terraform Cloud.

## Prerequisites

Before using this configuration, you must have the following:

- Terraform installed. You can install it from [here](https://www.terraform.io/downloads.html).
- AWS credentials configured. Either set up environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`) or use AWS CLI configuration.

## Module Configuration

The VPC setup is managed via a Terraform module, sourced from a remote GitHub repository.

```hcl
module "vpc" {
  source          = "git::https://github.com/sammielas/vpc_module.git"
  region          = var.region
  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr
  pub_sub_1a_cidr = var.pub_sub_1a_cidr
  pub_sub_2b_cidr = var.pub_sub_2b_cidr
  pri_sub_3a_cidr = var.pri_sub_3a_cidr
  pri_sub_4b_cidr = var.pri_sub_4b_cidr
}
```

This module requires the following inputs:
- `region`: The AWS region where the VPC will be created.
- `project_name`: The name of the project, used to identify resources.
- `vpc_cidr`: The CIDR block for the VPC.
- `pub_sub_1a_cidr` and `pub_sub_2b_cidr`: The CIDR blocks for public subnets.
- `pri_sub_3a_cidr` and `pri_sub_4b_cidr`: The CIDR blocks for private subnets.

## Variables

The following variables should be defined to customize your VPC setup:

```hcl
variable "region" {}
variable "project_name" {}
variable "vpc_cidr" {}
variable "pub_sub_1a_cidr" {}
variable "pub_sub_2b_cidr" {}
variable "pri_sub_3a_cidr" {}
variable "pri_sub_4b_cidr" {}
```

Default values can be assigned to these variables in a `terraform.tfvars` or `variables.tf` file.

Example:

```hcl
region          = "us-east-1"
project_name    = "matrimony"
vpc_cidr        = "10.0.0.0/16"
pub_sub_1a_cidr = "10.0.1.0/24"
pub_sub_2b_cidr = "10.0.2.0/24"
pri_sub_3a_cidr = "10.0.3.0/24"
pri_sub_4b_cidr = "10.0.4.0/24"
```

## Providers

This configuration uses the AWS provider, specified as follows:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }
  }
}

provider "aws" {
  region = var.region
}
```

Ensure that the version specified for the AWS provider is compatible with your Terraform version.

## Getting Started

1. Clone this repository.
2. Initialize Terraform in your working directory:
   ```bash
   terraform init
   ```
3. Set up your environment with the necessary variables, or update `terraform.tfvars` with appropriate values.
4. Run the plan command to preview the infrastructure changes:
   ```bash
   terraform plan
   ```
5. Apply the changes to create the infrastructure:
   ```bash
   terraform apply
   ```

## Usage

The primary goal of this setup is to provision a custom VPC in AWS with public and private subnets across multiple availability zones. You can extend this configuration by adding more modules or customizing the `vpc_module`.

## License

This project is open-source and available under the [MIT License](LICENSE).

