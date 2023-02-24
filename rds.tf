# This block provisions RDS Instance On AWS

resource "aws_db_instance" "mysql5" {
  allocated_storage      = var.RDS_MYSQL_STORAGE
  identifier             = "roboshop-${var.ENV}-mysql"
  engine                 = "mysql"
  engine_version         = var.RDS_MYSQL_ENGINE_VERSION
  instance_class         = var.RDS_INSTANCE_TYPE
  username               = "admin1"
  password               = "RoboShop1"
  parameter_group_name   = aws_db_parameter_group.mysql.name
  db_subnet_group_name   = aws_db_subnet_group.mysql.name
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.allow_mysql.id]
}


# Creates MySQL Parameter Group
resource "aws_db_parameter_group" "mysql" {
  name   = "roboshop-${var.ENV}-mysql-pg"
  family = "mysql${var.RDS_MYSQL_ENGINE_VERSION}"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}


# Creates subnet group for RDS
resource "aws_db_subnet_group" "mysql" {
  name       = "roboshop-${var.ENV}-rds-pg"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "roboshop-${var.ENV}-mysql-subnet-grp"
  }
}
