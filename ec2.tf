resource "aws_instance" "public_servers" {
  count                       = var.env == "DEV" ? 3 : 2
  ami                         = var.imagename
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = element(aws_subnet.public-subnets.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.app_sg.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "${var.vpc_name}-public-Server-${count.index + 1}"
    Env        = var.env
    Owner      = "Tulasi"
    CostCenter = "ABCD"
  }
  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y nginx jq net-tools
    echo "<h1>${var.vpc_name}-public-Server-${count.index + 1}</h1>" | sudo tee /var/www/html/index.nginx-debian.html
    EOF

}

