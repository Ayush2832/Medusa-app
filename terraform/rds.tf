resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
    ]

  tags = {
    Name = "RDS subnet group"
  }
}

resource "aws_db_instance" "postgres" {
  identifier              = "my-postgres-db"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "postgres"
  instance_class          = "db.t3.micro"
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  port                    = 5432
  vpc_security_group_ids  = [aws_security_group.main_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name

  skip_final_snapshot     = true
  publicly_accessible     = true

  depends_on = [ aws_db_subnet_group.rds_subnet_group ]

  tags = {
    Name = "PostgreSQL-RDS"
  }
}
