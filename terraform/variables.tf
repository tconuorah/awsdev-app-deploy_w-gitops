variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-cluster"
}

variable "cluster_version" {
  type    = string
  default = "1.31"
}


variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
  default     = "eks-node-group"
}

variable "node_name_pattern" {
  description = "Pattern for naming EKS worker nodes"
  type        = string
  default     = "EKS-App-Worker Node"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"

}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "github_org" {
  type        = string
  description = "github org/username"
  default     = "tconuorah"
}

variable "github_repo" {
  type        = string
  description = "github repo name"
  default     = "awsdev-app-deploy_w-gitops"
}

variable "github_branch" {
  type        = string
  description = "Branch allowed to assume this role (e.g., gitops)"
  default     = "gitops"
}

variable "role_name" {
  type        = string
  description = "IAM role name for GitHub Actions OIDC"
  default     = "github-actions-oidc-role"
}

variable "ecr_repo_arn" {
  type        = string
  description = "ARN of the ECR repo (or use '*' if you prefer, but repo ARN is safer)"
  default     = ""
}

# OPTIONAL: If you want to deploy to EKS from GitHub Actions, you’ll need cluster access.
# Leave empty if you only need ECR permissions.
variable "eks_cluster_arn" {
  type        = string
  description = "ARN of EKS cluster (optional)"
  default     = ""
}