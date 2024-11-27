#!/bin/bash

yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "Terraform is an IAC tool, used primarily by DevOps teams to automate various infrastructure tasks. The provisioning of cloud resources, for instance, is one of the main use cases of Terraform. It's a cloud-agnostic, open-source provisioning tool written in the Go language and created by HashiCorp. $(hostname -f)" > /var/www/html/index.html
