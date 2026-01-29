module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.private[*].id

  enable_irsa = true

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true


  eks_managed_node_groups = {
    worker-node = {
      instance_types = ["t3.medium"]
      min_size       = 2
      max_size       = 4
      desired_size   = 2
    }
  }

  tags = var.tags
}

resource "aws_security_group_rule" "jenkins_to_eks_api" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = module.eks.cluster_security_group_id
  source_security_group_id = aws_security_group.jenkins_master.id
  description              = "Allow Jenkins to reach EKS API"
}