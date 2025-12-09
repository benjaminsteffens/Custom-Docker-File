🚀#**Ansible AWS Provisioner and Deployment Pipeline**
This project provides an automated, end-to-end solution for provisioning AWS infrastructure using Terraform, deploying a Dockerized application using Ansible, and orchestrating the entire process via a GitHub Actions workflow.

✨ Features
Infrastructure as Code (IaC): Defines and manages AWS resources (like an EC2 instance) using Terraform.

Automated Deployment: Uses Ansible to connect to the provisioned EC2 instance, authenticate with AWS ECR, and deploy a specified Docker image.

Container Lifecycle Management: The Ansible playbook ensures the old container is stopped and removed before pulling and running the new container.

CI/CD Pipeline: A GitHub Actions workflow automates the execution of the provisioning and deployment tasks on a manual trigger.

Secure Access: AWS and SSH credentials are securely managed using GitHub Secrets.

🛠️ Tech Stack
Component	Tool / Technology	Purpose
Orchestration	GitHub Actions	CI/CD pipeline automation and execution
Configuration Mgmt.	Ansible	Remote command execution and application deployment
Infrastructure	Terraform	Provisioning AWS resources
Cloud Provider	AWS (EC2, ECR)	Target infrastructure and container registry
Application	Docker	Containerization of the application
Language	YAML	For GitHub Workflow and Ansible Playbook
Language	HCL	For Terraform Configuration

Export to Sheets

⚙️ Prerequisites
Before you begin, ensure you have the following configured:

AWS Account: An active AWS account with necessary permissions (EC2, ECR, IAM).

GitHub Repository: This repository must contain the provided workflow, playbook, and configuration files.

Docker Image: A Docker image pushed to the specified AWS ECR repository URI: 640168422415.dkr.ecr.us-east-1.amazonaws.com/ben/test:latest.

🔒 Configuration & Secrets
The GitHub Actions workflow relies on several repository secrets for authentication. You must set these up in your GitHub repository's settings under Settings > Secrets and variables > Actions.

Secret Name	Purpose	Example Value
AWS_ACCESS_KEY_ID	Your AWS Access Key ID	AKIAIOSFODNN7EXAMPLE
AWS_SECRET_ACCESS_KEY	Your AWS Secret Access Key	wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
ANISBLETESTSECRET	SSH Private Key for the EC2 Instance	Private key contents (starting with -----BEGIN OPENSSH PRIVATE KEY-----...)

Export to Sheets

🚀 Getting Started
1. File Structure
Ensure your repository has the following file structure:

.
├── .github/workflows/
│   └── aws-provisioner.yml  # Your GitHub Actions workflow
├── automate.yml             # Your Ansible Playbook
├── hosts.ini                # Your Ansible Inventory (or named differently)
└── main.tf                  # Your Terraform Configuration
Note: The GitHub Actions workflow assumes the Ansible playbook is named automate.yml.

2. Manual Execution via GitHub Actions
The workflow is configured to run manually using the workflow_dispatch trigger.

Navigate to the Actions tab in your GitHub repository.

Select the Ansible AWS Provisioner workflow.

Click Run workflow and confirm the branch.

3. Workflow Steps (Internal Logic)
The provision-aws-resources job executes the following sequence:

Checkout Code: Retrieves the repository files.

Configure AWS Credentials: Sets up the AWS CLI environment using the provided secrets for the us-east-1 region.

Install Ansible: Installs the ansible package on the GitHub Actions runner.

Execute AWS Playbook: Runs the core deployment logic using ansible-playbook automate.yml.

💻 Ansible Playbook (automate.yml) Overview
The Ansible playbook's primary role is to deploy the Docker image from ECR to the target EC2 instance.

Target: hosts: [linux_ec2] (The host defined in your inventory file).

Variables: Defines ecr_repo_uri, container_name, ports, and region.

Deployment Tasks
Task Name	Description
1. Get ECR Docker login password	Uses aws ecr get-login-password on the local runner (delegate_to: localhost) to securely fetch a temporary authentication token.
2. Set the ECR login host	Extracts the registry URL from the full repository URI.
3. Log in to ECR on the EC2 instance	Uses the fetched password to log in to ECR on the remote EC2 instance.
4. Ensure old container is stopped and removed	Stops and deletes any existing container with the same name.
5. Pull the image from ECR	Downloads the latest image from the authenticated ECR repository.
6. Run the new container	Starts the new container, ensuring it runs on port 80 on the host, mapping to container port 8080.

Export to Sheets

🌐 Ansible Inventory (hosts.ini)
The inventory file maps the logical host name (linux_ec2) to the target EC2 instance and specifies the necessary connection details.

Ini, TOML

[linux_ec2]
54.162.162.133 \
    ansible_user=ec2-user \
    ansible_ssh_private_key_file={{ secrets.ANISBLETESTSECRET }}
IMPORTANT: You must replace 54.162.162.133 with the public IP address or DNS name of your provisioned EC2 instance.

🧱 Terraform Configuration
The project includes a basic Terraform resource definition (likely in main.tf) to define the EC2 instance.

Terraform

resource "aws_instance" "bentest" {
  ami           = "" # AMI ID must be provided here
  instance_type = "t2.micro"

  tags = {
    Name = "pipelinetest"
  }
}
Note: For a complete solution, you would need to integrate terraform apply into the GitHub Actions workflow before the Ansible playbook runs, and also pass the dynamically created EC2 IP address into the Ansible inventory. This current setup requires the IP to be manually updated in the inventory.

🤝 Contribution
Feel free to open an issue or submit a pull request if you have suggestions for improvements or encounter bugs.# Custom-Docker-File
