#===============Security Group===============

resource "aws_security_group" "rds-sg" {
  name        = "${var.env}-rds-sg"
  description = "Allow TLS inbound traffic and all outbound traffic inside from cluster"
  vpc_id      = aws_vpc.eks-vpc.id

  tags = {
    Name = "${var.env}-rds-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_mysql" {
  security_group_id = aws_security_group.rds-sg.id
  cidr_ipv4         = aws_vpc.eks-vpc.cidr_block
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

#===============Subnet Group===============

resource "aws_db_subnet_group" "rds-sng" {
  name       = "${var.env}-rds-subnet-group"
  subnet_ids = [aws_subnet.eks-vpc-priv-sub1.id, aws_subnet.eks-vpc-priv-sub2.id]

  tags = {
    Name = "${var.env}-rds-subnet-group"
  }
}

#===============Parameter Group===============

resource "aws_db_parameter_group" "rds-pg" {
  name   = "${var.env}-rds-pg"
  family = "mysql5.7"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}
