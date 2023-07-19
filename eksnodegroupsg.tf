resource "aws_security_group" "eks_node_group_sg" {
  name        = "eks-node-group-sg"
  description = "Custom security group for EKS node group"
  vpc_id      = aws_vpc.main.id

  # Define inbound and outbound rules as per your requirements
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.kubectl-server.private_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}