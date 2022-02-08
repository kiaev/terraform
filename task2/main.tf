provider "aws" {
    access_key = var.acc_key
    secret_key = var.sec_key
    region = "eu-central-1"
}


resource "aws_instance" "web" {
  ami = "ami-04c921614424b07cd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_sec_web.id]
  user_data = <<EOF
  #!/bin/bash
  sudo amazon-linux-extras install nginx1
  sudo systemctl enable nginx
  sudo systemctl start nginx
  EOF
}

resource "aws_security_group" "my_sec_web" {
  name = "my_sec_web"
  description = "my_sec_web"
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_db_instance" "default" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0.20"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "rza"
  password             = "12345678"
  vpc_security_group_ids = [aws_security_group.my_sec_db.id]
}

resource "aws_security_group" "my_sec_db" {
  name = "my_sec_db"
  description = "my_sec_db"
  ingress {
    description = "http"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}




