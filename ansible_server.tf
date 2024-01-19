# Provisioning of Ansible Master and Node

resource "aws_instance" "ansible-master" {
  ami                    = "ami-05a36e1502605b4aa"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.food-pub-sn.id
  key_name               = "devops_1"
  vpc_security_group_ids = [aws_security_group.allow_food.id]
  private_ip             = "10.0.1.10"

  tags = {
    Name = "Ansible Master"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install git",
      "git clone https://github.com/Ayoyinka2456/Ansible-FoodApp.git",
      "cd Ansible-FoodApp",
      "sudo chmod 400 devops_1.pem",
      "sudo yum -y install epel-release",
      "sudo yum -y install ansible",
      "ansible -m ping -i host.ini n1",
      "ansible-playbook setup_food.yml -i host.ini",
    ]

    connection {
      type        = "ssh"
      user        = "centos"
      private_key = file("/home/centos/devops_1.pem")
      host        = self.public_ip
    }
  }
}

resource "aws_instance" "n1" {
  ami                    = "ami-05a36e1502605b4aa"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.food-pub-sn.id
  key_name               = "devops_1"
  vpc_security_group_ids = [aws_security_group.allow_food.id]
  private_ip             = "10.0.1.11"

  tags = {
    Name = "Ansible Node"
  }
}

