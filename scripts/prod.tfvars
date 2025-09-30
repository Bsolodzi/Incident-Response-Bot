region            = "eu-north-1" # AWS region for resource deployment
vpc_id            = "vpc-**********************" # VPC where the quarantine security group will be created
slack_webhook_url = "https://hooks.slack.com/services/********/*******/*******" # Slack webhook URL for notifications
minimum_severity  = 7 # Minimum severity level for GuardDuty findings