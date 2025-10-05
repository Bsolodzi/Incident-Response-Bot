# 🚨 Automated AWS Incident Response Bot

**Terraform | AWS GuardDuty | EventBridge | Lambda | Slack**

This project demonstrates how to build an **Automated AWS Incident Response Bot** that detects security findings from **AWS GuardDuty**, triggers an **AWS Lambda** function via **EventBridge**, and sends real-time notifications to a **Slack channel**. The entire infrastructure is provisioned using **Terraform**.

---

## 📘 Table of Contents

- [Overview](#-overview)
- [Architecture](#-architecture)
- [Key AWS Services](#-key-aws-services)
- [Features](#-features)
- [Prerequisites](#-prerequisites)
- [Setup Instructions](#-setup-instructions)
- [Terraform Deployment](#-terraform-deployment)
- [Slack Integration Setup](#-slack-integration-setup)
- [Testing the Bot](#-testing-the-bot)
- [Cleanup](#-cleanup)
- [Future Improvements](#-future-improvements)
- [Author](#-author)
- [License](#-license)

---

## 📖 Overview 

Cloud environments are continuously exposed to security threats. **AWS GuardDuty** helps detect malicious activities such as unauthorized access, data exfiltration, or crypto-mining.  
This project automates the response to such incidents using a **serverless workflow** that integrates AWS services and **Slack notifications** for real-time alerting.

When a GuardDuty finding occurs:

1. **GuardDuty** detects and publishes the finding.
2. **EventBridge** triggers an **AWS Lambda** function.
3. The **Lambda** function parses the finding and sends a formatted alert to **Slack**.
4. The security team can take quick action.

---

## 🏗 Architecture

![Architecture Diagram Placeholder](images/architecture-diagram.png)

---

## ☁️ Key AWS Services

| Service             | Purpose                                       |
| ------------------- | --------------------------------------------- |
| **AWS GuardDuty**   | Detects security threats automatically        |
| **AWS EventBridge** | Routes GuardDuty findings to Lambda           |
| **AWS Lambda**      | Processes the findings and sends Slack alerts |
| **Terraform**       | Automates infrastructure provisioning         |
| **Slack Webhook**   | Receives real-time security notifications     |

---

## ✨ Features

- Fully automated infrastructure deployment using **Terraform**
- Event-driven **incident response pipeline**
- Real-time alerts to **Slack**
- Simple and modular code structure
- Secure IAM permissions following least-privilege principle

---

## 🧰 Prerequisites

Before you begin, ensure you have the following:

- ✅ [AWS Account](https://aws.amazon.com/resources/create-account/) with administrative access
- ✅ [Terraform v1.5+](https://developer.hashicorp.com/terraform/downloads) installed
- ✅ [AWS CLI](https://aws.amazon.com/cli/) configured (`aws configure`)
- ✅ Slack workspace with permission to create an **Incoming Webhook**
- ✅ [Python 3.9+](https://www.python.org/downloads/) installed (for Lambda function)

---

## ⚙️ Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/<your-username>/aws-incident-response-bot.git
cd aws-incident-response-bot
```

2. Configure AWS Credentials

Ensure your credentials are set up and valid:

```bash
aws configure
``` 

### 3. Create a Slack Webhook

- Go to your Slack workspace → Apps → Manage Apps → Custom Integrations → Incoming Webhooks

- Create a new webhook and copy the Webhook URL

- Add it to your environment variables file (terraform.tfvars or AWS SSM Parameter Store)

slack_webhook_url = "https://hooks.slack.com/services/XXXX/YYYY/ZZZZ"

## 🏗 Terraform Deployment

1. Initialize Terraform
```
bash terraform init
```

3. Review the Plan
```
bash terraform plan
```

3. Apply the Configuration
```
bash terraform apply
```

When prompted, confirm with `yes`.

Terraform will provision:

- IAM Roles & Policies
- EventBridge Rule
- Lambda Function
- GuardDuty detector (if not enabled)

## 💬 Slack Integration Setup

The Lambda function sends messages to Slack using your webhook.
Example of Slack message payload (Python snippet inside Lambda):

```bash
import json, os, urllib3

def lambda_handler(event, context):
    webhook_url = os.environ['SLACK_WEBHOOK_URL']
    http = urllib3.PoolManager()

    for record in event['detail']['findings']:
        title = record['Title']
        severity = record['Severity']
        region = record['Region']
        description = record['Description']

        message = {
            "text": f"*AWS GuardDuty Alert*\n*Title:* {title}\n*Severity:* {severity}\n*Region:* {region}\n*Description:* {description}"
        }
        http.request('POST', webhook_url, body=json.dumps(message), headers={'Content-Type': 'application/json'})
```

## 🧪 Testing the Bot

You can test the setup by:

Generating sample GuardDuty findings:

```bash 
aws guardduty create-sample-findings --detector-id <detector-id>
```

Check your Slack channel — you should receive a message within seconds.

Review the Lambda CloudWatch logs to verify event processing.

## 🧹 Cleanup

To remove all created resources and avoid charges:

```bash
terraform destroy 
```

Confirm with `yes`.

## 🚀 Future Improvements

- Add automated remediation steps (e.g., isolate EC2 instance, revoke IAM credentials)

- Add support for multiple notification channels (Teams, SNS, PagerDuty)

- Integrate with AWS Security Hub for centralized visibility

- Use AWS Step Functions for advanced workflows

## 👨‍💻 Author

Bernard Kwame Solodzi

🧠 Research Software Engineer / Cloud Enthusiast

🌍 LinkedIn

💻 GitHub

## 📄 License

This project is licensed under the MIT License
.
