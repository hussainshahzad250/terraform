#create bucket using terraform script
resource "aws_s3_bucket" "mybucket" {
  bucket = "my-tf-test-bucket250"
  acl    = "private"

  versioning {
    enabled = false
  }

  tags = {
    Name        = "My bucket"
    Environment = "UAT"
  }
}