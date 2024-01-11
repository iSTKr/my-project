# GitHub Actions, Terraform, Kubernetes, and Helm Demonstration with Guestbook Application

## Introduction
This repository serves as a demonstration of integrating GitHub Actions, Terraform, Kubernetes, and Helm, exemplified through a simple Guestbook application.

## Application Architecture
The application is composed of Docker images for the frontend and Redis:
- **Frontend**: Contains PHP code for the Guestbook website, enabling users to leave messages.
- **Redis Image**: Serves as the database for storing these messages.

## Pipelines
### `provision_eks_cluster.yml`
- **Purpose**: Deploys AWS infrastructure, which includes EKS, VPC, ECR, and auxiliary resources.
- **State File Storage**: Maintains the state file on an S3 backend.

### `destroy_eks_cluster.yml`
- **Functionality**: Destroys the previously created infrastructure.

### `build_push_deploy.yml`
- **Process**:
  1. Builds the Docker image of the application and pushes it to ECR.
  2. Builds a corresponding version of the Helm chart, which includes the new image version and templates for deploying application components.
  3. Pushes the Helm chart to the relevant ECR repository.
  4. Installs the Helm chart onto the pre-established cluster.
- **Versioning**:
  - Retrieves application and chart versions from `Chart.yaml` and passes them to the respective builds.
  - Enables the creation of images and charts with corresponding versions, allowing for independent deployment of each.

### `uninstall_helm.yml`
- **Objective**: Pipeline for removing the Helm chart from the cluster.

## Automation Features
- **Git Tag Integration**: The main pipeline `build_push_deploy.yml` is configured to automatically trigger upon the creation of a Git tag, thus facilitating automated deployments in response to version tagging.
