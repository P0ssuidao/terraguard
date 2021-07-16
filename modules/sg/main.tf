resource "aws_security_group" "terraguard-sg" {
  name        = "terraguard-sg"
  description = "Allow traffic to terraguard"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "WIREVPN PORT"
    from_port   = 41194
    to_port     = 41194
    protocol    = "UDP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "terraguard-sg"
  }
}
