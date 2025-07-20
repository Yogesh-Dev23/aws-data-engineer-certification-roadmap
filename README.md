# AWS Data Engineer Certification Practical Roadmap

This repository is for **practical hands-on preparation** for the **AWS Data Engineer Associate Certification**, structured week-by-week for **clarity, tracking, and easy resumption**.

---

## 📂 Folder Structure

We will use **12 clear, sequential folders** for each week:

* `week01_data_fundamentals_and_sql/`
* `week02_cli_and_terraform/`
* `week03_iam_networking_encryption/`
* `week04_spark_hadoop_local/`
* `week05_emr_and_spark_on_aws/`
* `week06_s3_and_glue_catalog/`
* `week07_glue_etl_pyspark/`
* `week08_redshift_deep_dive/`
* `week09_serverless_and_streaming/`
* `week10_airflow_orchestration/`
* `week11_monitoring_logging_security/`
* `week12_exam_prep_and_mocks/`

👉 Each folder will contain:

* `docs/` → Notes and summaries
* `scripts/` → Python/PySpark/Terraform scripts
* `labs/` → Practice exercises and notebooks

---

## ⚡ Commands to Create Week Folders

Run this **in your local cloned repo root**:

```bash
# Read README.md lines
$lines = Get-Content .\README.md

for ($i = 1; $i -le 12; $i++) {
    $num = "{0:D2}" -f $i

    # Find the matching line for weekXX_
    $matchedLine = $lines | Where-Object { $_ -match "week${num}_" } | Select-Object -First 1

    if ($null -ne $matchedLine) {
        # Use single quotes to avoid escape issues, match text between backticks
        if ($matchedLine -match '`([^`]+)`') {
            $folderName = $matches[1].TrimEnd("/")
        } else {
            Write-Host "⚠️ Could not extract folder name for week$num, skipping..."
            continue
        }

        # Create the week folder
        if (-not (Test-Path $folderName)) {
            New-Item -ItemType Directory -Path $folderName | Out-Null
        }

        # Create docs, labs, scripts inside the week folder
        foreach ($sub in "docs", "labs", "scripts") {
            $subPath = Join-Path $folderName $sub
            if (-not (Test-Path $subPath)) {
                New-Item -ItemType Directory -Path $subPath | Out-Null
            }
        }

        Write-Host "✅ Created: $folderName with docs, labs, scripts"
    } else {
        Write-Host "⚠️ No matching line found for week$num, skipping..."
    }
}

```

---

## 👨‍💻 Local Environment Setup

### 1. Clone this repo locally:

```bash
git clone https://github.com/YOUR_USERNAME/aws-data-engineer-certification-roadmap.git
cd aws-data-engineer-certification-roadmap
```

---

### 2. Create a Python virtual environment:

```bash
python -m venv venv
```

Activate:

* **Windows:**

  ```bash
  .\venv\Scripts\activate
  ```
* **Mac/Linux:**

  ```bash
  source venv/bin/activate
  ```

---

### 3. Install dependencies (initially empty, update as you add):

```bash
pip install -r requirements.txt
```

---

### 4. Add new dependencies as you progress:

```bash
pip install NEW_PACKAGE
pip freeze > requirements.txt
```

---

## ☁️ AWS EC2 Setup for Hands-On

### 1. Generate or use an existing SSH key pair from AWS Console:

* Go to **EC2 → Key Pairs → Create key pair**.
* Download `your-key.pem` securely.

---

### 2. Launch a t2.micro EC2 instance (Free Tier) from AWS Console:

* Amazon Linux 2023 or Ubuntu 22.04 LTS.
* Attach the **key pair you created**.
* Allow SSH (port 22) in the security group.

---

### 3. SSH into your EC2 instance from your local machine:

```bash
ssh -i /path/to/your-key.pem ec2-user@YOUR_EC2_PUBLIC_IP
```

🚨 Replace `/path/to/your-key.pem` and `YOUR_EC2_PUBLIC_IP`.

---

### 4. Clone your repo on the EC2 instance:

```bash
mkdir -p ~/projects
cd ~/projects
git clone https://github.com/YOUR_USERNAME/aws-data-engineer-certification-roadmap.git
cd aws-data-engineer-certification-roadmap
```

---

### 5. On the EC2 instance:

* Install Python if needed (`sudo yum install python3` or `sudo apt install python3-pip`).

* Create and activate a virtual environment:

  ```bash
  python3 -m venv venv
  source venv/bin/activate
  ```

* Install dependencies:

  ```bash
  pip install -r requirements.txt
  ```

---

## 🔄 Workflow Recap

👉 **Do your week’s work inside `weekXX_*` folders.**
👉 Commit and push regularly:

```bash
git add .
git commit -m "Completed Week X lab"
git push origin main
```

👉 **SSH into EC2 when needed to test workloads (PySpark, AWS CLI, etc.).**
👉 Pull updates:

```bash
git pull
```

---

## 💡 Notes

* Stopping your EC2 retains the disk (EBS). You can restart without data loss.
* `terraform` usage will be added later to automate EC2, S3, IAM.
* You can add `notebooks/` folders if working with Jupyter locally or on EC2.
* Track your weekly progress using a `progress.md` in each folder if desired.

---

**✨ You are now ready for systematic, organized hands-on AWS Data Engineer certification preparation.**

---

### 👩‍💻 Happy Learning!
