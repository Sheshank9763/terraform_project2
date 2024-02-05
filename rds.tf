resource "aws_db_instance" "rds1" {
  vpc_security_group_ids = [aws_security_group.sg1.id]
  availability_zone = "us-west-2a"
  allocated_storage    = 10
  db_name              = "mydb1"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "rds1"
  password             = "Rdsmysql123"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  tags = {
    Name = "rds1"
  }
  db_subnet_group_name = aws_db_subnet_group.db_subnet1.name
}
resource "aws_db_instance" "rds2" {
  vpc_security_group_ids = [aws_security_group.sg1.id]
  allocated_storage    = 10
  db_name              = "mydb2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "rds1"
  password             = "Rdsmysql123"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  multi_az = true
  tags = {
    Name = "rds2multiaz"
  }
  db_subnet_group_name = aws_db_subnet_group.db_subnet2.name
 }
resource "aws_db_subnet_group" "db_subnet1" {
    subnet_ids = [aws_subnet.private1.id,aws_subnet.public2.id]
    name = "subnetgroup1"
}
resource "aws_db_subnet_group" "db_subnet2" {
    subnet_ids = [aws_subnet.private2.id,aws_subnet.public1.id,aws_subnet.private3.id]
    name = "subnetgroup2"
}