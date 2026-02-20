# Week 05 — EMR + Spark (Terraform)

## Goal
Run Apache Spark on Amazon EMR using Terraform in a cost-safe, reproducible way.

This week focuses on:
- Understanding EMR architecture
- Running Spark on YARN
- Managing EMR clusters using Terraform
- Avoiding manual console dependency

---

## What I Will Build
- Terraform-managed EMR cluster (1 master, 1 core)
- Spark job submitted as an EMR step
- Logs stored in Amazon S3
- Clean teardown using `terraform destroy`

---

## Why Terraform (Instead of Console)
- Reproducibility
- Version control
- Cost safety
- Industry-standard practice

---

## Status
- [ ] Terraform provider setup
- [ ] IAM roles for EMR
- [ ] EMR cluster via Terraform
- [ ] Spark job execution
- [ ] Cluster termination
