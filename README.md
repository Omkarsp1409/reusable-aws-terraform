📌 Project Overview

This project demonstrates how to design and implement reusable AWS infrastructure using Terraform Infrastructure as Code (IaC).

The objective is to create standardized Terraform modules for networking, compute, security, and monitoring that can be configured for multiple environments:

Development (DEV)

Staging (STAGING)

Production (PROD)

Instead of writing infrastructure configurations repeatedly, this project uses reusable modules, input variables, outputs, resource tagging, and environment-specific .tfvars files.

🎯 Project Objectives

Implement reusable Terraform modules.

Automate AWS infrastructure provisioning through IaC.

Create standardized VPC networking architecture.

Deploy configurable EC2 instances.

Implement reusable security group configurations.

Monitor EC2 CPU utilization using Amazon CloudWatch.

Manage different infrastructure configurations using environment-specific variable files.

Follow Terraform formatting and validation practices.

🏗️ Architecture

The project consists of four reusable Terraform modules.

                  Terraform Root Configuration
                            |
          +-----------------+-----------------+
          |                 |                 |
          v                 v                 v
      VPC Module       Security Group      EC2 Module
          |                 |                 |
          v                 v                 v
       AWS VPC          AWS Security       EC2 Instance
       Subnets             Group            Amazon Linux 2023
       Route Tables                          EBS Volume
       Internet Gateway                          |
                                                 v
                                          Monitoring Module
                                                 |
                                                 v
                                          AWS CloudWatch
                                            CPU Alarm

Environment Architecture

The same Terraform module architecture is configured using different environment variable files.

Environment

VPC CIDR

EC2 Instance

Root Volume

CPU Threshold

DEV

10.10.0.0/16

t3.micro

8 GB

80%

STAGING

10.20.0.0/16

t3.small

15 GB

75%

PROD

10.30.0.0/16

t3.medium

30 GB

70%

These are example configurations for learning and demonstration, not production sizing recommendations.

🛠️ Technologies Used

Technology

Purpose

Terraform

Infrastructure as Code

AWS VPC

Network infrastructure

AWS EC2

Compute resources

AWS Security Groups

Network traffic control

AWS CloudWatch

Infrastructure monitoring

AWS Systems Manager Parameter Store

Amazon Linux 2023 AMI lookup

HCL

Terraform configuration language

Git & GitHub

Version control and project management

📂 Project Structure

reusable-aws-terraform/
│
├── environments/
│   ├── dev/
│   │   └── terraform.tfvars
│   │
│   ├── staging/
│   │   └── terraform.tfvars
│   │
│   └── prod/
│       └── terraform.tfvars
│
├── modules/
│   │
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── security-group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── monitoring/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── docs/
│   └── terraform-state-management.md
│
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── .gitignore
└── README.md

📦 Terraform Modules

1. VPC Module

Location: modules/vpc/

Creates reusable AWS networking infrastructure.

Features:

Custom VPC creation.

Public subnet creation.

Private subnet creation.

Internet Gateway configuration.

Public route table.

Private route table.

Route table associations.

Configurable CIDR blocks and Availability Zones.

Resource tagging.

2. Security Group Module

Location: modules/security-group/

Creates reusable AWS security groups.

Features:

Configurable security group name.

VPC association.

Ingress rules.

Egress rules.

Configurable ports and protocols.

CIDR-based traffic rules.

Resource tagging.

3. EC2 Module

Location: modules/ec2/

Creates reusable EC2 instances.

Features:

Configurable instance name.

Configurable instance type.

Dynamic Amazon Linux 2023 AMI lookup.

Subnet association.

Security group attachment.

Configurable root EBS volume.

EBS encryption.

IMDSv2 enforcement.

Instance ID and IP address outputs.

4. Monitoring Module

Location: modules/monitoring/

Creates CloudWatch CPU utilization alarms.

Features:

EC2 CPU utilization monitoring.

Configurable CPU threshold.

Five-minute monitoring period.

Two evaluation periods.

CloudWatch alarm outputs.

Resource tagging.

Note: SNS notifications are not currently implemented.

⚙️ Prerequisites

Before using this project, install:

Terraform CLI (version 1.5.0 or higher).

AWS CLI.

An AWS account.

Git.

Valid AWS credentials with appropriate permissions.

Verify installations:

terraform version
aws --version
git --version

Configure AWS authentication using an AWS CLI profile or another supported credential method.

Verify account access:

aws sts get-caller-identity

Never store AWS access keys or secret keys in Terraform files or GitHub.

🚀 Getting Started

Step 1: Clone the repository

git clone <YOUR_GITHUB_REPOSITORY_URL>

Navigate into the project:

cd reusable-aws-terraform

Step 2: Initialize Terraform

terraform init

This initializes the working directory and downloads the required Terraform providers.

Step 3: Format Terraform files

terraform fmt -recursive

Step 4: Validate the configuration

terraform validate

Expected result:

Success! The configuration is valid.

Step 5: Generate the development plan

terraform plan -var-file="environments/dev/terraform.tfvars"

Step 6: Generate the staging plan

terraform plan -var-file="environments/staging/terraform.tfvars"

Step 7: Generate the production plan

terraform plan -var-file="environments/prod/terraform.tfvars"

Review every plan before considering deployment.

Important: Different .tfvars files do not automatically provide independent Terraform states. The current implementation uses one root configuration and does not implement remote state isolation. Do not apply multiple environments against the same state.

🧠 Terraform Concepts Demonstrated

Concept

Application

Modules

Reusable infrastructure components

Input Variables

Dynamic configuration

Outputs

Resource information sharing

count

Multiple resource creation

merge()

Combining resource tags

Data Sources

Retrieving the latest Amazon Linux 2023 AMI

terraform.tfvars

Environment-specific values

Variable Validation

Input validation

Resource Dependencies

Connecting infrastructure modules

🔐 Security Best Practices

Use IAM least-privilege permissions.

Never commit AWS credentials.

Keep Terraform state files out of Git.

Enable EBS encryption.

Enforce IMDSv2.

Restrict unnecessary inbound traffic.

Avoid exposing SSH to the public internet.

Prefer AWS Systems Manager Session Manager for administration.

Review Terraform plans before deployment.

Protect sensitive configuration files.

💰 Cost Considerations

This project uses AWS resources that may incur charges when deployed.

Potential cost areas:

EC2 instance runtime.

EBS storage.

Public IPv4 addresses.

CloudWatch alarms and monitoring.

Internet data transfer.

Terraform planning does not create infrastructure. Always review AWS pricing and your account's Free Tier eligibility before deployment.

📊 Project Implementation Status

Component

Status

Terraform project structure

Completed

AWS provider configuration

Configured

Reusable VPC module

Implemented

Reusable Security Group module

Implemented

Reusable EC2 module

Implemented

CloudWatch monitoring module

Implemented

DEV configuration

Plan successful

STAGING configuration

Plan successful

PROD configuration

Plan successful

S3 remote backend

Out of scope

Live deployment testing

Not confirmed

🔮 Future Enhancements

Potential improvements for future iterations:

Independent state isolation for environments.

S3 remote backend and native state locking.

SNS notifications for CloudWatch alarms.

Stronger network and CIDR validation.

Private EC2 deployment and Systems Manager integration.

Terraform security scanning.

GitHub Actions CI/CD pipeline.

Automated infrastructure testing.

📚 Learning Outcomes

Through this project, I practised:

Terraform module architecture.

AWS networking fundamentals.

EC2 provisioning.

Security group management.

CloudWatch monitoring.

Terraform variables and outputs.

Environment-based configuration.

Infrastructure validation and planning.

Troubleshooting Terraform configuration errors.

👨‍💻 Author

Omkar Pagade

Aspiring Cloud Engineer | AWS | Linux | Terraform | Networking

GitHub: [Add your GitHub profile URL]

LinkedIn: [Add your LinkedIn profile URL]

⭐ If you find this project useful, feel free to explore the repository and suggest improvements.

Disclaimer: This project is developed for learning and portfolio demonstration. Review and adapt all configurations before using them in production environments.
