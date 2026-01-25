resource "null_resource" "helm_cleanup" {
  provisioner "local-exec" {
    when    = destroy
    command = "helm uninstall aws-dev || true"
  }

  depends_on = [
    module.eks.cluster_name
  ]
}
