resource "null_resource" "mysql-schema" {
  
  # This is how we can create depenency and ensure this will only run after the creation if the RDS Instance.
  depends_on = [aws_db_instance.mysql5]

  provisioner "local-exec" {
        command = <<EOF
        cd /tmp 
        curl -s -L -o /tmp/mysql.zip "https://github.com/stans-robot-project/mysql/archive/main.zip"
        unzip -o mysql.zip 
        cd mysql-main 
        mysql -h ${aws_db_instance.mysql5.address} -u ${local.RDS_USER} -pRoboShop1 <shipping.sql
        EOF
  }  
}