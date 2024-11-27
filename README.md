# My_Terraform_Project1
![terraform project pic](https://github.com/user-attachments/assets/f5b7ab26-7ee5-49ac-9a3e-8ae9c525d6cf)

1.	Install Terraform:
o	Download from the official website.
o	Verify: terraform --version
2.	Set Up Workspace:
bash
mkdir terraform-project && cd terraform-project
3.	Write Configuration Files:
o	main.tf:
hcl
provider "aws" {
  region = "us-west-2"
}
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
4.	Initialize Terraform:
bash
terraform init
5.	Validate Configuration:
bash
terraform validate
6.	Format Files (Optional):
bash
terraform fmt
7.	Preview Changes:
bash
terraform plan
8.	Apply Changes:
bash
terraform apply
9.	Manage State:
bash
terraform show
10.	Modify Infrastructure:
o	Update .tf files.
o	Run: terraform plan then terraform apply
11.	Destroy Infrastructure:
bash
terraform destroy
This should help you get started with Terraform efficiently! 😊

