#===============RDS DB Instance===============

resource "aws_db_instance" "rds-instance" {
  allocated_storage    = 20
  identifier           = "${var.env}-databse"
  db_name              = "testdb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "pAssword123"
  parameter_group_name = aws_db_parameter_group.rds-pg.id
  db_subnet_group_name = aws_db_subnet_group.rds-sng.id
  vpc_security_group_ids = [ aws_security_group.rds-sg.id ]
  skip_final_snapshot = true # Not recomended for production environment
}