# IAM Users, Groups, and Policies – Phase 1 Lab 1

## Objective
The objective of this lab was to understand AWS IAM fundamentals by creating IAM users and groups, attaching a least-privilege custom policy, and verifying permissions through both the AWS Console and AWS CLI.

---

## Key Concepts Learned

### IAM Users
- IAM users represent individual human identities.
- Users should never be granted permissions directly in production environments.

### IAM Groups
- IAM groups are used to manage permissions at scale.
- Users inherit permissions from groups they are added to.

### IAM Policies
- Policies define what actions are allowed or denied.
- Custom (customer-managed) policies provide better control than AWS-managed policies.

### Least Privilege Principle
- Permissions were limited strictly to what was required.
- The user was intentionally denied access to all non-S3 services.

---

## Implementation Details

### IAM Group
- **Group Name:** `s3-readonly-group`
- **Purpose:** Provide read-only access to Amazon S3

---

### Custom IAM Policy
- **Policy Name:** `S3ReadOnlyCustomPolicy`

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "S3ReadOnlyAccess",
      "Effect": "Allow",
      "Action": [
        "s3:ListAllMyBuckets",
        "s3:ListBucket",
        "s3:GetObject"
      ],
      "Resource": "*"
    }
  ]
}
