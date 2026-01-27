# Phase 3 – Compute and Load Balancing (AWS + Terraform)

## Overview

Phase 3 focuses on compute scalability and traffic distribution using AWS core services. In this phase, I designed and implemented a highly available web architecture on AWS, first using the AWS Console to understand the fundamentals, and then rebuilding the same architecture using Terraform as Infrastructure as Code.

The goal of this phase is to move from a single EC2 instance to a production-style architecture that supports:

- Auto healing
- Auto scaling
- Load balancing
- Multi-AZ availability

## Architecture Summary

The architecture directs user traffic through an Application Load Balancer, which distributes requests across healthy EC2 instances managed by an Auto Scaling Group.

```plaintext
      User
       |
       |  HTTP (80)
       v
+-----------------------------+
| Application Load Balancer   |
+-----------------------------+
       |
       | Distributes Traffic
       v
+-----------------------------+
|    Auto Scaling Group       |
|                             |
|   +-------+     +-------+   |
|   |  EC2  |     |  EC2  |   |
|   | NGINX |     | NGINX |   |
|   +-------+     +-------+   |
|                             |
+-----------------------------+
```

## Services Used

- **Amazon EC2**
- **Auto Scaling Group (ASG)**
- **Application Load Balancer (ALB)**
- **Target Groups**
- **Security Groups**
- **Amazon CloudWatch**
- **Terraform** (Infrastructure as Code)

## Phase 3 Labs Breakdown

### Lab 1 – EC2 Instance with Web Server

**Objective:**
- Launch a free-tier EC2 instance
- Configure security groups
- Use user data to install and start NGINX

**Key Learnings:**
- EC2 provisioning
- AMI selection
- Key pairs and SSH access
- User data for bootstrapping servers
- Security group behavior

### Lab 2 – Auto Scaling Group

**Objective:**
- Create a Launch Template
- Deploy an Auto Scaling Group
- Configure desired, minimum, and maximum capacity
- Implement CPU-based scaling

**Key Learnings:**
- Difference between EC2 and scalable compute
- Launch Templates vs Launch Configurations
- Auto healing of failed instances
- Target tracking scaling policies
- CloudWatch metrics driving automation

### Lab 3 – Application Load Balancer

**Objective:**
- Create an Application Load Balancer
- Configure a Target Group with health checks
- Attach the ALB to the Auto Scaling Group
- Route traffic across multiple EC2 instances

**Key Learnings:**
- Load balancing concepts
- Health-based routing
- Decoupling users from backend servers
- High availability using multi-AZ subnets
- Production-style web architecture

## Terraform Implementation

All Phase 3 labs were rebuilt using Terraform to ensure:
- Repeatability
- Version control
- Safe creation and destruction of infrastructure
- Clear mapping between AWS Console actions and Terraform resources

Each lab is:
- Standalone
- Free-tier safe
- Easily destroyable using `terraform destroy`

---

## How to Deploy (Terraform)

```bash
terraform init
terraform plan
terraform apply
```
