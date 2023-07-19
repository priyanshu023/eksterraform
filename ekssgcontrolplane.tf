resource "aws_security_group" "clustersg" {
  name        = "eks-cluster-sg"
  description = "coustmized sg of cluster"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "to connect with bastion host"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.kubectl-server.private_ip}/32"]
  }

  ingress {
    description = "Default rule"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    #cidr_blocks = [""]
    self = true
  }

  egress {
    description = "outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "clustersg"
  }
}