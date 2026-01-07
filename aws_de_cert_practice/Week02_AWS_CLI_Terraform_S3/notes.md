# Week 2 Notes: AWS CLI, Terraform, and S3

This file contains short notes and practical steps for each subtopic covered in Week 2.

## Subtopics

### 1. AWS CLI Basics
- **Commands**:
  - `aws s3 mb s3://bucket-name`: Create a bucket.
  - `aws s3 cp file.txt s3://bucket-name`: Upload a file.
  - `aws s3 sync ./local-folder s3://bucket-name`: Sync a folder.
- **Practice**:
  - Create a bucket.
  - Enable versioning.
  - Upload files and sync folders.

### 2. Terraform Basics
- **Concepts**:
  - Providers, resources, and state management.
  - Modules for reusable code.
- **Practice**:
  - Write Terraform code to create an S3 bucket.
  - Add versioning and lifecycle rules.

### 3. S3 Bucket Properties
- **Features**:
  - Versioning: Keep multiple versions of an object.
  - Lifecycle Rules: Transition objects to Glacier or delete them.
  - Event Notifications: Trigger Lambda functions.
- **Practice**:
  - Enable versioning and lifecycle rules.
  - Configure event notifications.

### 4. Data Lake Structure
- **Folders**:
  - `raw/`: Unprocessed data.
  - `processed/`: Cleaned data.
  - `analytics/`: Aggregated data.
- **Practice**:
  - Create the folder structure in S3.
  - Upload sample data.

### 5. Encryption and Security
- **Concepts**:
  - SSE-S3, SSE-KMS, and SSE-C.
  - IAM roles and policies.
- **Practice**:
  - Enable encryption on the bucket.
  - Create an IAM role with S3 permissions.

## Access Point

Request comes in
   ↓
IAM Policy (who are you?)
   ↓
Access Point Policy (can you use THIS door?)
   ↓
Bucket Policy (can this object be accessed?)
   ↓
Object

## VPC Endpoint

EC2 (Private Subnet)
   |
   |  Route table rule: S3 → Gateway Endpoint
   |
AWS Private Backbone
   |
S3 Service
   |
Access Point (policy check)
   |
S3 Bucket (objects)


