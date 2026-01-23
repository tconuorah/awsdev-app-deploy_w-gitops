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
  type = string
  default = "10.0.0.0/16"
  
}

variable "jenkins_role_name" {
  type    = string
  default = "jenkins-ec2-role"
}

variable "jenkins_instance_profile_name" {
  type    = string
  default = "jenkins-profile"
}

# If Jenkins runs on EC2 inside your VPC, pass its security group id.
variable "jenkins_security_group_id" {
  type = string
}

