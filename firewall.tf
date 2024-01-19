resource "aws_security_group" "allow_food" {
  name        = "Food SSH-HTTP"
  description = "Allow SSH-HTTP inbound traffic"
  vpc_id      = aws_vpc.food-vpc.id

  ingress {
    description = "SSH from WWW"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
}
  ingress {
    description = "HTTP from WWW"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
}
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
}

  tags = {
    Name = "FOOD SG"
  }
}


