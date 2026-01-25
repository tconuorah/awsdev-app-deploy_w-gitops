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


variable "vpc_cidr" {
  type    = string
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


variable "cluster_version" {
  type    = string
  default = "1.31"
}

variable "vpc_id" {
  type = string
  default = ""
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for EKS (subnet_ids in the module)"
  type        = list(string)
  default     = []
}

variable "tags" {
  type    = map(string)
  default = {}
}

