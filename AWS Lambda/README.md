
# AWS Lambda – Serverless & Messaging (Phase 6)

This repository contains **three hands-on AWS Lambda labs** completed as part of **Phase 6: Serverless & Messaging Services**.  
All infrastructure is provisioned using **Terraform**, with a focus on **event-driven, time-driven, and request-driven serverless architectures**.

The goal of these labs is to gain **practical, production-relevant understanding** of how AWS Lambda integrates with core AWS services.

---

## 🔧 Technologies Used

- AWS Lambda
- Amazon S3
- Amazon EventBridge
- Amazon API Gateway
- AWS IAM
- Amazon CloudWatch Logs
- Terraform (Infrastructure as Code)
- Python 3.10

---

## 🧪 Lab 1: S3-Triggered Lambda (Event-Driven)

### Objective
Build an **event-driven serverless workflow** where a Lambda function is automatically triggered when a file is uploaded to an S3 bucket.

### What Was Implemented
- Private S3 bucket
- Lambda function triggered on `ObjectCreated` events
- IAM role with least-privilege permissions
- Automatic file copy to a `processed/` prefix
- CloudWatch logging for execution visibility

### Key Concepts Learned
- Event-driven architecture
- S3 event notifications
- Lambda execution roles
- Service-to-service permissions
- Secure, serverless file processing

---

## ⏰ Lab 2: Scheduled Lambda (EventBridge)

### Objective
Replace traditional cron jobs with a **fully managed serverless scheduler**.

### What Was Implemented
- Lambda function triggered on a fixed schedule
- Amazon EventBridge rule using `rate()` expression
- Automatic execution without servers
- Logs written to CloudWatch for verification

### Key Concepts Learned
- Time-driven serverless workflows
- EventBridge scheduling
- Why scheduled Lambdas are safer than EC2 cron jobs
- Reusable IAM execution roles

---

## 🌐 Lab 3: API Gateway + Lambda (Serverless API)

### Objective
Build a **serverless REST API** without EC2, load balancers, or web servers.

### What Was Implemented
- API Gateway REST API
- `/hello` GET endpoint
- Lambda proxy integration
- Public API endpoint
- Terraform-managed deployment and stage
- Output of invoke URL using `outputs.tf`

### Example API Response
```json
{
  "message": "Hello from serverless API",
  "source": "API Gateway + Lambda"
}


