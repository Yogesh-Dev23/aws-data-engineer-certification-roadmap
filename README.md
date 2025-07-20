# AWS Data Engineer Certification Practical Roadmap

This repository is for **practical hands-on preparation** for the **AWS Data Engineer Associate Certification**, structured **week-by-week for clarity, tracking, and easy resumption** while allowing **flexibility in the learning order**.

---

## Folder Structure

✨ **Flexible, on-demand creation:**

* Create `weekXX_topic/` folders **manually as you progress**.
* Start with **any topic (e.g., S3 before SQL)** based on your plan.
* Each `weekXX_topic/` folder may contain:

  * `cheat_sheet.md` → Short notes, diagrams, CLI commands, quick recalls.
  * `scripts/` → Python, PySpark, Terraform, or shell scripts.
  * `labs/` → Practice notebooks or structured exercises.

⚡ **No rigid structure enforced**; build structure based on **actual workflows**.

---

## Local Environment Setup

### 1️⃣ Clone your repository locally:

```bash
git clone https://github.com/YOUR_USERNAME/aws-data-engineer-certification-roadmap.git
cd aws-data-engineer-certification-roadmap
```

---

### 2️⃣ Create a Python virtual environment:

```bash
python -m venv venv
```

Activate:

* **Windows:**

  ```powershell
  .\venv\Scripts\activate
  ```
* **Mac/Linux:**

  ```bash
  source venv/bin/activate
  ```

---

### 3️⃣ Install dependencies:

Initially, your `requirements.txt` will be empty. As you add packages:

```bash
pip install -r requirements.txt
```

---

### 4️⃣ Add new dependencies as you progress:

When you add packages:

```bash
pip install NEW_PACKAGE
pip freeze > requirements.txt
```

---

## AWS EC2 Workflow

Use an **EC2 instance for heavier or AWS-integrated workloads while keeping consistency with local environments**.

### 1️⃣ Generate or use an existing SSH key pair:

* **AWS Console → EC2 → Key Pairs → Create key pair**
* Download `your-key.pem` securely.

---

### 2️⃣ Launch an EC2 instance:

* Use Amazon Linux 2023 or Ubuntu 22.04 LTS.
* Attach the key pair you created.
* Allow SSH (port 22) in the security group.

---

### 3️⃣ SSH into your EC2 instance:

```bash
ssh -i /path/to/your-key.pem ec2-user@YOUR_EC2_PUBLIC_IP
```

---

### 4️⃣ Clone your repository on EC2:

```bash
mkdir -p ~/projects
cd ~/projects
git clone https://github.com/YOUR_USERNAME/aws-data-engineer-certification-roadmap.git
cd aws-data-engineer-certification-roadmap
```

---

### 5️⃣ Create and activate a virtual environment on EC2:

```bash
python3 -m venv venv
source venv/bin/activate
```

Install your synced dependencies:

```bash
pip install -r requirements.txt
```

---

## Workflow Recap

✅ **Do your week's work inside `weekXX_topic/` folders you create manually.**
✅ Keep a `cheat_sheet.md` for each week with **commands, notes, and references**.
✅ Version your work with Git:

```bash
git add .
git commit -m "Completed Week 06 S3 and Glue lab"
git push
```

✅ On EC2, pull updates:

```bash
git pull
```

✅ Use your **virtual environment (`venv`) consistently on local and EC2**.

---

## Tips

✅ Stop EC2 when not in use to avoid costs; data persists on restart.
✅ Use `notebooks/` inside `weekXX_topic/` if you need Jupyter workflows.
✅ Add `terraform/` under a week if you begin Infra as Code practice.
✅ Update `requirements.txt` regularly to maintain environment reproducibility.

---

## Ready to Learn

You are now set up for **structured yet flexible, clean, and reproducible AWS Data Engineer certification preparation** with **low RAM efficiency and consistent workflow across local and EC2 environments**.

---

### Happy Learning and Building!
