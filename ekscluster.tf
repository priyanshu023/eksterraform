resource "aws_eks_cluster" "eks" {
  name     = "cluster-eks"
  role_arn = aws_iam_role.master.arn
  version = "1.26"
  #create_security_group = false
  

  #vpc Configuration
  vpc_config {
    subnet_ids = [aws_subnet.public-1.id, aws_subnet.public-2.id, aws_subnet.public-3.id]
    security_group_ids = [aws_security_group.clustersg.id]
    endpoint_private_access = true
    endpoint_public_access  = false
    
  }

  #Execute after all of this.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,

  ]

}