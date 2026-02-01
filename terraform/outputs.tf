output "ecr" {
  value = aws_ecr_repository.app.name
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "github_actions_role_arn" {
  value = aws_iam_role.github_actions.arn
}

output "github_oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.github.arn
}