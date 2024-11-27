#!/bin/bash

yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "Terraform's main disadvantage is its complexity in managing large-scale state files, which can lead to challenges in collaboration and state conflicts. $(hostname -f)" > /var/www/html/index.html

}
