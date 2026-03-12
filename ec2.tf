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

apt update -y
apt install nginx -y
apt install git -y

systemctl enable nginx
systemctl start nginx

cd /home/ubuntu
git clone -b main https://github.com/VaraLakshmiTulasi/web_application.git

rm -rf /var/www/html/index.nginx-debian.html

cp web_application/index.html /var/www/html/index.nginx-debian.html
cp web_application/css/style.css /var/www/html/style.css
cp web_application/js/script.js  /var/www/html/script.js

echo "<h1>${var.vpc_name}-Public-Server-${count.index + 1}</h1>" >> /var/www/html/index.nginx-debian.html

EOF
}

