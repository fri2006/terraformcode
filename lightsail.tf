resource "aws_lightsail_instance" "gitlab_test" {
  name              = "custom_gitlab"
  availability_zone = "us-east-1a"
  blueprint_id      = "amazon_linux_2"
  bundle_id         = "nano_1_0"
  #key_pair_name     = "some_key_name"
  tags = {
    env = "dev"
  }
}
resource "aws_lightsail_instance" "example" {
  name              = "example-instance"
  availability_zone = "us-east-1a" # Replace with your desired availability zone
  instance_plan     = "nano_2_0"
  key_pair_name     = "my-key-pair" # Replace with your key pair name

  user_data = <<-EOF
    #!/bin/bash
    sudo yum install httpd -y
    sudo systemctl start httpd
    sudo systemctl enable httpd
    echo "<h1>This Server is created using Terraform </h1>" | sudo tee /var/www/html/index.html
    EOF
}

output "public_ip" {
  value = aws_lightsail_instance.example.public_ip_address
}