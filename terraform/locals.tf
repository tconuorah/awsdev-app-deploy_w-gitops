locals {
  # Restrict to your repo AND a specific branch via GitHub's OIDC token claims.
  # sub format: repo:<org>/<repo>:ref:refs/heads/<branch>
  github_sub = "repo:${var.github_org}/${var.github_repo}:ref:refs/heads/${var.github_branch}"
}