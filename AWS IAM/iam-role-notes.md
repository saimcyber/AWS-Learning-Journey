# IAM Role Lab Notes – Phase 1 Lab 2

## Objective
The purpose of this lab was to understand and implement AWS IAM Roles, enable Multi-Factor Authentication (MFA), and securely allow an EC2 instance to access AWS services without using long-term access keys.

---

## Key Concepts Learned

### 1. Root Account Security
- Enabled MFA on the AWS root account.
- Root account is now protected against password compromise.
- Root access is used only for account-level operations, not daily work.

---

### 2. IAM User MFA
- Enabled MFA for the IAM user `lab-s3-user`.
- Ensures that even if credentials are leaked, access cannot be gained without the MFA device.

---

### 3. IAM Users vs IAM Roles

| IAM User | IAM Role |
|--------|---------|
| Used by humans | Used by AWS services |
| Long-term credentials | Temporary credentials |
| Requires access keys | No access keys needed |
| Higher risk if leaked | More secure by design |

**Key takeaway:**  
Production EC2 instances should always use IAM Roles instead of access keys.

---

## IAM Role Implementation

### Role Name
