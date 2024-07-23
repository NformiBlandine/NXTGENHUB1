
output "kubeconfig-certificate-authority-data" {
  sensitive = true
  value     = aws_eks_cluster.this.certificate_authority[0].data
}

output "endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_id" {
  value = aws_eks_cluster.this.id
}
