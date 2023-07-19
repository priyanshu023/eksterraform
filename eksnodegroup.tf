resource "aws_instance" "kubectl-server" {
  ami                         = var.ami
  key_name                    = var.keypair
  instance_type               = var.instancetype
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public-1.id
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]

  tags = {
    Name = "bastion host and Kubectl server"
  }

}
resource "aws_eks_node_group" "node-grp" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "eks-node-group"
  node_role_arn   = aws_iam_role.worker.arn
  subnet_ids      = [aws_subnet.public-1.id, aws_subnet.public-2.id, aws_subnet.public-3.id]
  capacity_type   = "ON_DEMAND"
  disk_size       = "8"
  instance_types  = [var.instancetype]


   remote_access {
    ec2_ssh_key               = var.keypair
    source_security_group_ids = [aws_security_group.eks_node_group_sg.id]
  }


  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
   
  ]
}