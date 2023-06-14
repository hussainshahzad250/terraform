resource "aws_instance" "jenkins" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = "test"
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids = [aws_security_group.allow_login.id]
  tags = {
    Name = var.project
    OS   = "ubuntu"
  }
  user_data = <<EOC
#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5BA31D57EF5975CA

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
sudo echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install default-jdk -y
sudo apt-get install jenkins -y
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo apt-get install python3-pip -y
sudo pip3 install awscli
sudo apt-get install unzip
wget -q https://releases.hashicorp.com/terraform/0.11.6/terraform_0.11.6_linux_amd64.zip
unzip terraform_0.11.6_linux_amd64.zip
mv terraform /usr/local/bin/terraform
terraform version
echo "#########   all commands executed successfuly !! ########## "
EOC
}
