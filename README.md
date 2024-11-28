# My_Terraform_Project1
![terraform project pic](https://github.com/user-attachments/assets/f5b7ab26-7ee5-49ac-9a3e-8ae9c525d6cf)

𝟏.	𝐈𝐧𝐬𝐭𝐚𝐥𝐥 𝐓𝐞𝐫𝐫𝐚𝐟𝐨𝐫𝐦:
	Download from the official website.
	Verify: terraform --version
𝟐.	𝐒𝐞𝐭 𝐔𝐩 𝐖𝐨𝐫𝐤𝐬𝐩𝐚𝐜𝐞:
  𝐛𝐚𝐬𝐡
  mkdir terraform-project && cd terraform-project
𝟑.	𝐖𝐫𝐢𝐭𝐞 𝐂𝐨𝐧𝐟𝐢𝐠𝐮𝐫𝐚𝐭𝐢𝐨𝐧 𝐅𝐢𝐥𝐞𝐬:
	𝐦𝐚𝐢𝐧.𝐭𝐟:
 provider "aws" {
   region = "us-west-2"
 }
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
𝟒.	𝐈𝐧𝐢𝐭𝐢𝐚𝐥𝐢𝐳𝐞 𝐓𝐞𝐫𝐫𝐚𝐟𝐨𝐫𝐦:
   "terraform init"
𝟓.	𝐕𝐚𝐥𝐢𝐝𝐚𝐭𝐞 𝐂𝐨𝐧𝐟𝐢𝐠𝐮𝐫𝐚𝐭𝐢𝐨𝐧:
𝐛𝐚𝐬𝐡
  terraform validate
𝟔.	𝐅𝐨𝐫𝐦𝐚𝐭 𝐅𝐢𝐥𝐞𝐬 (𝐎𝐩𝐭𝐢𝐨𝐧𝐚𝐥):
𝐛𝐚𝐬𝐡
  terraform fmt
𝟕.	𝐏𝐫𝐞𝐯𝐢𝐞𝐰 𝐂𝐡𝐚𝐧𝐠𝐞𝐬:
𝐛𝐚𝐬𝐡
  terraform plan
𝟖.	𝐀𝐩𝐩𝐥𝐲 𝐂𝐡𝐚𝐧𝐠𝐞𝐬:
𝐛𝐚𝐬𝐡
  terraform apply
𝟗.	𝐌𝐚𝐧𝐚𝐠𝐞 𝐒𝐭𝐚𝐭𝐞:
𝐛𝐚𝐬𝐡
  terraform show

𝟏𝟎.	𝐃𝐞𝐬𝐭𝐫𝐨𝐲 𝐈𝐧𝐟𝐫𝐚𝐬𝐭𝐫𝐮𝐜𝐭𝐮𝐫𝐞:
𝐛𝐚𝐬𝐡
terraform destroy

This should help you get started with Terraform efficiently! 😊
