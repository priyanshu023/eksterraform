output "clustersgout" {
    value = aws_security_group.clustersg.id
  
}
output "publicip" {
    value = aws_instance.kubectl-server.public_ip
  
}
/*output "default_cluster_by_eks" {
    value = aws_eks_cluster.eks.cluster_security_group_id
  
}*/