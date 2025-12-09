#  Ansible AWS Provisioner and Deployment Pipeline

This project provides an automated, end-to-end solution for provisioning AWS infrastructure using **Terraform**, deploying a Dockerized application using **Ansible**, and orchestrating the entire process via a **GitHub Actions** workflow.

##  Features

* **Infrastructure as Code (IaC):** Defines and manages AWS resources (like an EC2 instance) using **Terraform**.
* **Automated Deployment:** Uses **Ansible** to connect to the provisioned EC2 instance, authenticate with AWS ECR, and deploy a specified Docker image.
* **Container Lifecycle Management:** The Ansible playbook ensures the old container is stopped and removed before pulling and running the new container.
* **CI/CD Pipeline:** A **GitHub Actions** workflow automates the execution of the provisioning and deployment tasks on a manual trigger.
* **Secure Access:** AWS and SSH credentials are securely managed using GitHub Secrets.

##  Tech Stack

| Component | Tool / Technology | Purpose |
| :--- | :--- | :--- |
| **Orchestration** | GitHub Actions | CI/CD pipeline automation and execution |
| **Configuration Mgmt.** | Ansible | Remote command execution and application deployment |
| **Infrastructure** | Terraform | Provisioning AWS resources |
| **Cloud Provider** | AWS (EC2, ECR) | Target infrastructure and container registry |
| **Application** | Docker | Containerization of the application |
| **Language** | YAML | For GitHub Workflow and Ansible Playbook |
| **Language** | HCL | For Terraform Configuration |

##  Prerequisites

Before you begin, ensure you have the following configured:

1.  **AWS Account:** An active AWS account with necessary permissions (EC2, ECR, IAM).
2.  **GitHub Repository:** This repository must contain the provided workflow, playbook, and configuration files.
3.  **Docker Image:** A Docker image pushed to the specified AWS ECR repository URI: `640168422415.dkr.ecr.us-east-1.amazonaws.com/ben/test:latest`.

##  Configuration & Secrets

The GitHub Actions workflow relies on several repository secrets for authentication. You must set these up in your GitHub repository's settings under **Settings > Secrets and variables > Actions**.

| Secret Name | Purpose | Example Value |
| :--- | :--- | :--- |
| `AWS_ACCESS_KEY_ID` | Your AWS Access Key ID | `AKIAIOSFODNN7EXAMPLE` |
| `AWS_SECRET_ACCESS_KEY` | Your AWS Secret Access Key | `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY` |
| `ANISBLETESTSECRET` | SSH Private Key for the EC2 Instance | Private key contents (starting with `-----BEGIN OPENSSH PRIVATE KEY-----...`) |

##  Getting Started

### 1. File Structure

Ensure your repository has the following file structure:
