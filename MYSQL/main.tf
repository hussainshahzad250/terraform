# CREATE RDS (MYSQL) using terraform script
resource "aws_db_instance" "myrds" {
  storage_type        = var.storage_type
  engine              = var.engine
  identifier          = var.identifier
  engine_version      = var.engine_version
  instance_class      = var.db_instance_class
  username            = var.username
  password            = var.password
  allocated_storage   = var.dbstorage
  publicly_accessible = var.publicly_accessible
  skip_final_snapshot = var.skip_final_snapshot

  tags = {
    "Name" = format("%s-%s-%s-RDS-DB", var.environment, var.clientName, var.product)
  }
}
