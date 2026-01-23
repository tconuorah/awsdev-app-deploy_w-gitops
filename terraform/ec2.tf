# Get latest Ubuntu 22.04 AMI dynamically
data "aws_ami" "ubuntu_2204" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# EC2 Instance for Jenkins Master
resource "aws_instance" "jenkins_master" {
  ami                    = data.aws_ami.ubuntu_2204.id
  instance_type          = "t3.medium"
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.jenkins_master.id]
  key_name               = "prod"

  iam_instance_profile = aws_iam_instance_profile.jenkins.name 

  associate_public_ip_address = true  # ✅ This enables SSH from outside

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name = "jenkins-master"
  }
} 

resource "aws_eks_access_entry" "jenkins" {
  cluster_name  = aws_eks_cluster.main.name
  principal_arn = aws_iam_role.jenkins_ec2.arn
  type          = "STANDARD"
}


resource "aws_security_group_rule" "eks_allow_jenkins" {
  type                     = "ingress"
  security_group_id        = aws_security_group.eks_cluster.id
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.jenkins_master.id

  description = "Allow Jenkins EC2 to access EKS API server"
}


resource "aws_iam_role" "jenkins_ec2" {
  name = var.jenkins_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_instance_profile" "jenkins" {
  name = var.jenkins_instance_profile_name
  role = aws_iam_role.jenkins_ec2.name
}

resource "aws_iam_role_policy_attachment" "jenkins_ecr_power" {
  role       = aws_iam_role.jenkins_ec2.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}
resource "aws_iam_role_policy_attachment" "jenkins_eks_describe" {
  role      = aws_iam_role.jenkins_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

