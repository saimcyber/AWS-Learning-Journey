
# AWS S3 – Storage Services (Phase 4)

This phase focuses on **Amazon S3 (Simple Storage Service)** and covers both hands-on console usage and Infrastructure as Code using Terraform.

The goal is to understand how S3 works internally, how it is secured, and how it is automated in real-world environments.

**Service covered:** Amazon S3

---

## What I Learned in This Phase

* How Amazon S3 stores and manages objects at scale
* How to secure S3 buckets using best practices
* How **static websites** are hosted without servers
* How **lifecycle policies** reduce long-term storage costs
* How to automate S3 using Terraform
* Common misconfigurations and how to debug them

---

## Labs Overview

### Lab 1: Secure S3 Bucket with Versioning (Console)
**Objective:** Create a secure S3 bucket, enable versioning, and enable default encryption.

**Key Concepts:**
* **Bucket Versioning:** Protects against accidental overwrite and deletion.
* **Server-Side Encryption (SSE-S3):** Ensures data is encrypted at rest (AES-256).
* **Block Public Access:** Prevents accidental data exposure.

**What was done:**
1.  Created an S3 bucket from the AWS Console.
2.  Enabled versioning.
3.  Enabled default encryption (AES-256).
4.  Uploaded and updated objects to verify version retention.

### Lab 2: Static Website Hosting (Console + Terraform)
**Objective:** Host a static website using Amazon S3 and understand public access controls.

**Key Concepts:**
* S3 can host static websites using HTTP.
* Bucket policies are required for public read access.
* **Block Public Access** must be carefully managed.

**What was done (Console):**
* Created a new S3 bucket and enabled static website hosting.
* Uploaded `index.html` and `error.html`.
* Applied a public-read bucket policy.
* Accessed the site using the S3 website endpoint.

**What was done (Terraform):**
* Created S3 bucket using Terraform.
* Disabled Block Public Access programmatically.
* Configured static website hosting.
* Uploaded website files using `aws_s3_object`.
* Applied public bucket policy with correct dependency handling.

### Lab 3: Lifecycle Policies & Glacier (Console + Terraform)
**Objective:** Automatically move data to cheaper storage tiers and implement cost optimization.

**Key Concepts:**
* **Lifecycle Rules:** Automate data transitions based on object age.
* **Glacier:** Used for long-term archival.
* **Expiration:** Versioned buckets require cleanup policies for non-current versions.

**What was done:**
1.  Created lifecycle rules to move objects to Glacier after **30 days**.
2.  Configured rules to delete non-current versions after **90 days**.
3.  Verified lifecycle configuration.
4.  Implemented lifecycle rules using Terraform.

---

## Terraform Highlights

**Key Terraform resources used:**
* `aws_s3_bucket`
* `aws_s3_bucket_public_access_block`
* `aws_s3_bucket_policy`
* `aws_s3_bucket_website_configuration`
* `aws_s3_bucket_lifecycle_configuration`
* `aws_s3_bucket_versioning`
* `aws_s3_object`

> **Important Learning:** Terraform does not automatically handle S3 public access ordering. `depends_on` is required to avoid `AccessDenied` errors when applying public policies because S3 Block Public Access overrides IAM permissions.

---

## Common Issues & Debugging

| Issue | Root Cause | Solution |
| :--- | :--- | :--- |
| **AccessDenied** | Public policies are prevented by the `BlockPublicPolicy` setting. | S3 Block Public Access was still enabled when applying a public bucket policy. |
| **Fix** | N/A | Explicitly disable Block Public Access and enforce correct Terraform execution order using `depends_on`. |

This mirrors real-world production troubleshooting.

---

## Repository Structure

```text
Phase-4-S3/
├── Lab-1-Versioning-Encryption/
├── Lab-2-Static-Website/
├── Lab-3-Lifecycle-Glacier/
└── lab-2-3-s3-terraform/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    └── index.html
