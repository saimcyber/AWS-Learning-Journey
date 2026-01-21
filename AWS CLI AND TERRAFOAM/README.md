# AWS CLI & Terraform Foundations (Labs 1–3)

This repository documents my hands-on learning of **AWS CLI and Terraform fundamentals**, following a structured AWS Cloud Learning Pathway.  
These labs focus on building a **strong foundation in Infrastructure as Code (IaC)**, secure authentication, and professional DevOps workflows using **AWS Free Tier only**.

---

## 🔹 Phase: Foundations – AWS CLI & Terraform

### Services & Tools Used
- AWS CLI
- Terraform
- AWS IAM
- Amazon S3
- Git & GitHub

---

## 🧪 Lab 1 – AWS CLI Basics

### 🎯 Objective
Understand how AWS CLI authenticates using IAM credentials and how Terraform uses the same credentials to provision AWS resources.

### 🔑 Key Concepts Learned
- AWS CLI configuration and authentication
- IAM access keys vs console login
- Verifying identity using AWS STS
- Testing permissions using AWS CLI
- Terraform provider configuration
- Initial resource provisioning using Terraform

### 🛠️ Key Commands Used
```bash
aws configure
aws sts get-caller-identity
aws s3 ls
terraform init
terraform plan
terraform apply

