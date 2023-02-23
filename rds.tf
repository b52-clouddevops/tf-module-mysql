# This block provisions RDS Instance On AWS

resource "aws_db_instance" "mysql5" {
  allocated_storage    = 10
  identifier           = "roboshop-${var.ENV}-mysql"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "admin1"
  password             = "RoboShop@1"
  parameter_group_name = 
  skip_final_snapshot  = true
}


# Creates MySQL Parameter Group
resource "aws_db_parameter_group" "mysql" {
  name   = "roboshop-${var.ENV}-mysql-pg"
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

# resource "aws_docdb_cluster" "docdb" {
#   cluster_identifier      = "roboshop-${var.ENV}-docdb"
#   engine                  = "docdb"
#   master_username         = "admin1"
#   master_password         = "roboshop1"
#   vpc_security_group_ids  = [aws_security_group.allow_mongodb.id]
#   db_subnet_group_name    = aws_docdb_subnet_group.docdb.id
# #   backup_retention_period = 5                        Uncomment only when you need backups
# #   preferred_backup_window = "07:00-09:00"
#   skip_final_snapshot     = false
# }

# # Creates Subnet Group 
# resource "aws_docdb_subnet_group" "docdb" {
#   name       = "roboshop-${var.ENV}-docdb-subnet-grp"
#   subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

#   tags = {
#     Name = "roboshop-${var.ENV}-docdb-subnet-grp"
#   }
# }

# # Provision the nodes needed for doc-db and add them to the docdb cluster.
# resource "aws_docdb_cluster_instance" "cluster_instances" {
#   count              = 1
#   identifier         = "roboshop-${var.ENV}-docdb-nodes"
#   cluster_identifier = aws_docdb_cluster.docdb.id
#   instance_class     = "db.t3.medium"
# }

# Our application is not designed to work with Document DB. That's because of the fact that AWS don't let youto create Document DB without Username and password
# Out cart and catalogue code is not designed to talk to mongodb with credentials.

# Let's try to understand, how can we connect to connect to doc-db. Based on that we can apply that strategy.