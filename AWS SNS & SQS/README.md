# AWS SNS & SQS – Messaging & Event-Driven Architecture (Phase 6)

This repository demonstrates **AWS messaging fundamentals** using **Amazon SNS** and **Amazon SQS**, implemented fully with **Terraform (Infrastructure as Code)**.

The labs focus on **decoupling services**, **fan-out patterns**, **failure handling with DLQs**, and **real-time serverless processing using Lambda**.

This project is part of **Phase 6 – Serverless & Messaging Services** in my AWS learning journey.

---

## 🧩 Services Used

- Amazon SNS (Simple Notification Service)
- Amazon SQS (Simple Queue Service)
- AWS Lambda
- AWS IAM
- Amazon CloudWatch Logs
- Terraform (IaC)
- Python 3.10

---

## 🏗 Architecture Overview

### 1️⃣ SNS → Multiple SQS Queues (Fan-out)

```

Producer
↓
SNS Topic
↓       ↓       ↓
SQS A   SQS B   SQS C
↓
Dead Letter Queue (DLQ)

```

### 2️⃣ SNS → Lambda (Real-time Processing)

```

Publisher
↓
SNS Topic
↓
Lambda Function
↓
CloudWatch Logs

```

---

## 📁 Repository Structure

```

Phase 6 - AWS SNS & AWS SQS/
├── main.tf          # Provider configuration
├── iam.tf           # IAM role and policies for Lambda
├── sns.tf           # SNS topic and subscriptions
├── sqs.tf           # SQS queues, DLQ, and queue policies
├── lambda.tf        # SNS-triggered Lambda function
├── outputs.tf       # Terraform outputs for testing
├── sns_lambda.py    # Lambda source code
└── README.md

````

---

## 🧪 Lab 1: SNS → SQS (Basic Fan-out)

### Objective
Create a **decoupled messaging system** where messages published to an SNS topic are delivered to an SQS queue.

### Key Learnings
- Publish/Subscribe messaging model
- SNS topic subscriptions
- SQS queue policies for secure message delivery
- Service-to-service trust using IAM

---

## 🧪 Lab 2: SNS → Multiple SQS Queues + DLQ

### Objective
Extend fan-out architecture by delivering messages to **multiple SQS queues**, each with its own failure handling.

### What Was Implemented
- Multiple SQS queues subscribed to a single SNS topic
- Dead Letter Queue (DLQ) for failed messages
- Redrive policies to isolate poison messages

### Key Learnings
- Failure isolation
- Retry behavior in SQS
- Why DLQs are critical in production systems

---

## 🧪 Lab 3: SNS → Lambda (Real-Time Serverless Processing)

### Objective
Trigger a Lambda function directly from SNS for **immediate event processing**.

### What Was Implemented
- Lambda subscription to SNS topic
- SNS permission to invoke Lambda
- CloudWatch logging for execution verification

### Lambda Behavior
- Receives SNS message
- Logs message content
- Confirms successful processing

---

## 🚀 Deployment Instructions

```bash
terraform init -upgrade
terraform plan
terraform apply
````

---

## 🧪 Testing the Setup

### Publish a message to SNS

```bash
aws sns publish \
  --topic-arn $(terraform output -raw sns_topic_arn) \
  --message "Test message from SNS"
```

### Receive messages from SQS queues

```bash
aws sqs receive-message \
  --queue-url $(terraform output -raw orders_queue_url)

aws sqs receive-message \
  --queue-url $(terraform output -raw billing_queue_url)

aws sqs receive-message \
  --queue-url $(terraform output -raw analytics_queue_url)
```

### Verify Lambda Execution

Check logs in:

```
/aws/lambda/phase6_sns_lambda
```

---

## 🔐 Security Best Practices Followed

* Least-privilege IAM policies
* Explicit service-to-service permissions
* No hardcoded credentials
* DLQ for failure visibility
* Fully managed services with no inbound ports

---

## 🎯 Key Takeaways

* SNS is ideal for **broadcasting events**
* SQS provides **durable message buffering**
* DLQs prevent system-wide failures
* SNS → Lambda enables real-time serverless automation
* Terraform enables reproducible, auditable infrastructure

---

## 🔜 Next Steps

* Add CloudWatch alarms for queue depth
* Encrypt SQS queues using KMS
* Integrate SQS with Lambda consumers
* Move to **Phase 7: Monitoring, Logging & Security**

---

## 👤 Author

**Saim Zaib**
Cybersecurity & Cloud enthusiast learning AWS through hands-on, production-style architectures.



## ✅ This README is:
- Clean  
- Professional  
- Resume-ready  
- Recruiter-friendly  
- GitHub-copy-paste safe  

If you want next, I can:
- ✂️ Shorten this for **portfolio view**
- 🧠 Review it from a **cloud security angle**
- 🚀 Move straight into **Phase 7**

Just tell me.
```
