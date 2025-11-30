# aws\_security\_cheat\_sheet

## 1. IAM Core Concepts

* **User**: Human/app with *long-term credentials* (password, access keys).
* **Group**: Collection of users with shared policies.
* **Role**: *Temporary identity* with permissions, *assumed* by trusted entities.
* **Policy**: JSON document defining *permissions* (actions, resources, conditions).

## 2. Policy Structure

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::my-bucket"
    }
  ]
}
```

* **Effect**: Allow/Deny.
* **Action**: Specific API actions.
* **Resource**: ARNs.
* **Condition**: Optional, e.g., IP restriction, MFA.

## 3. Roles vs Users

|             | IAM User         | IAM Role                |
| ----------- | ---------------- | ----------------------- |
| Represents  | Person/app       | Permissions set         |
| Credentials | Long-term        | Temporary, auto-rotated |
| Login       | Possible         | Not possible            |
| Usage       | Direct login/API | Must be assumed         |
| Use case    | Human/CLI        | EC2, Glue, Lambda       |

✅ EC2/Glue cannot have policies directly; **use IAM Roles**.

## 4. Key Security Services

* **AWS KMS**: Key management for encryption.
* **Secrets Manager**: Store/rotate secrets securely.
* **SSM Parameter Store**: Store configs and secrets.
* **CloudTrail**: API call audit logs.
* **Config**: Track resource configurations.
* **GuardDuty**: Threat detection.
* **Macie**: Sensitive data discovery.
* **Inspector**: Vulnerability scanning.

## 5. Encryption

* **At Rest**: KMS with EBS, S3, RDS.
* **In Transit**: TLS (HTTPS).
* **S3 Options**: SSE-S3, SSE-KMS, SSE-C.

## 6. Shared Responsibility Model

* AWS secures cloud infrastructure.
* **You secure data, configurations, IAM, encryption, applications.**

## 7. Best Practices

✅ Enable MFA for root/IAM users.
✅ Least privilege permissions.
✅ Use IAM Roles for services.
✅ Rotate access keys regularly.
✅ Enable CloudTrail in all regions.
✅ Encrypt sensitive data.
✅ Review IAM using Access Analyzer.
✅ Avoid using root user for daily tasks.

## 8. Common Confusion Q\&A

* **Q: Why can't I attach a policy directly to EC2?**
  **A:** EC2 is not an IAM entity; use IAM Role.

* **Q: Difference between User and Role?**
  **A:** User = long-term credentials; Role = temporary, assumed identity.

* **Q: Do Roles have passwords/access keys?**
  **A:** No, only temporary credentials when assumed.

* **Q: Why Roles over keys on EC2?**
  **A:** No hardcoding, auto-rotation, secure.

* **Q: Lambda access to S3?**
  **A:** IAM Role with S3 permissions attached.

* **Q: Managed vs Inline Policies?**
  **A:** Managed = reusable; Inline = tightly coupled to one entity.

* **Q: What is Envelope Encryption in KMS?**
  **A:** Data encrypted with Data Key, which is encrypted with CMK.

* **Q: Shared Responsibility Model (1-line)?**
  **A:** AWS secures infrastructure, you secure your data and configs.

* **Q: Root user best practice?**
  **A:** Enable MFA, avoid daily use.

* **Q: Can Roles be used for cross-account?**
  **A:** Yes, using trust policies.

## 9. CLI Commands

```bash
# List IAM users
aws iam list-users

# Get temporary credentials from EC2 metadata
curl http://169.254.169.254/latest/meta-data/iam/security-credentials/

# Check current caller identity
aws sts get-caller-identity

# Assume a role
aws sts assume-role --role-arn arn:aws:iam::ACCOUNT_ID:role/RoleName --role-session-name session1
```

---

If you want, request **Terraform lab examples, KMS-S3 encryption snippets, or hands-on CLI practice aligned with your AWS Data Engineer roadmap next.**
