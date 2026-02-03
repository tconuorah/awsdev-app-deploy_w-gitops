# GitOps CI/CD with GitHub Actions & Argo CD

GitOps CI/CD with GitHub Actions & Argo CD (Step-by-Step)
Overview
This document provides a complete step-by-step guide to implementing a GitOps-style CI/CD pipeline using GitHub Actions for CI and Argo CD for CD. This setup assumes you already have:
- An application
- A Helm chart
- An EKS Kubernetes cluster

GitHub Actions will build and push Docker images to Amazon ECR, while Argo CD will continuously sync your Helm charts from GitHub to your EKS cluster.
Architecture Flow
1. Developer pushes code to the `gitops` branch
2. GitHub Actions builds the Docker image
3. Image is pushed to Amazon ECR
4. Helm values.yaml is updated with the new image tag
5. Changes are committed back to the gitops branch
6. Argo CD detects the change and deploys to EKS

Step 1: Create GitOps Branch
git checkout main
git pull
git checkout -b gitops
git push -u origin gitops
Step 2: Prepare Helm Chart
Ensure your Helm chart values.yaml includes:

image:
  repository: ""
  tag: ""

And your deployment.yaml uses:
image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
Step 3: Create Amazon ECR Repository
aws ecr create-repository --repository-name myapp --region us-east-2
Step 4: Configure GitHub OIDC IAM Role
Create an IAM Role that GitHub Actions can assume using OIDC.
Attach permissions for ECR access.
Restrict trust policy to your repo and gitops branch.
Step 5: Configure GitHub Secrets and Variables
Secrets:
- AWS_ROLE_ARN

Variables:
- AWS_REGION
- ECR_REPOSITORY
- HELM_VALUES_FILE
Step 6: GitHub Actions Workflow
Create .github/workflows/gitops-ci.yml

Workflow handles:
- AWS authentication
- Docker build & push
- Helm values update
- Git commit back to gitops branch
Step 7: Install Argo CD on EKS
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
Step 8: Apply app using kubectl
kubectl apply -f argocd/app-awsdev-app.yml
Step 9: Create Argo CD Application
Create an Application manifest pointing to:
- repoURL: your GitHub repo
- targetRevision: gitops
- path: Helm chart directory
- automated sync enabled
Step 10: Validate Deployment
kubectl get pods -n myapp
kubectl describe deploy myapp -n myapp
Best Practices
- Treat Git as the single source of truth
- Never kubectl apply manually to app namespaces
- Use image tags (SHA or versioned)
- Enable Argo CD auto-sync and self-heal
Outcome
You now have a modern GitOps CI/CD pipeline where GitHub Actions handles CI and Argo CD handles CD, fully decoupled from Jenkins and aligned with industry best practices.