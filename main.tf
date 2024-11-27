resource "aws_vpc" "MyVpc" {
  cidr_block = var.cidr
  instance_tenancy = "default"

  tags = { 
     Name = "MyVpc"
   }
}

resource "aws_subnet" "sub1" {
    vpc_id = aws_vpc.MyVpc.id
    cidr_block = "18.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "sub2" {
    vpc_id = aws_vpc.MyVpc.id
    cidr_block = "18.0.2.0/24"
    availability_zone = "us-east-1c"
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "IGW" {
    vpc_id = aws_vpc.MyVpc.id
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.MyVpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.IGW.id
    }
}

resource "aws_route_table_association" "RTA1" {
   route_table_id = aws_route_table.RT.id
   subnet_id = aws_subnet.sub1.id
}

resource "aws_route_table_association" "RTA2" {
  route_table_id = aws_route_table.RT.id
  subnet_id = aws_subnet.sub2.id
}

resource "aws_security_group" "web-sg" {
  name        = "Web-sg"
  vpc_id      = aws_vpc.MyVpc.id

  ingress {
    description = "http from vpc"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

ingress {
    description = "ssh from vpc"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "sameeeb28031999"
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.example.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Principal = "*"
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.example.arn}/*"
      }
    ]
  })
}

resource "aws_key_pair" "my_key" {
  key_name   = "srikanth"
  public_key = file("~/.ssh/id_rsa.pub")  # Path to your public key file
}

#resource "aws_s3_bucket_acl" "example" {
 # depends_on = [
 #   aws_s3_bucket_ownership_controls.example,
  #  aws_s3_bucket_public_access_block.example,
  #]

#  bucket = aws_s3_bucket.name.id
 # acl    = "public-read"
#}


resource "aws_instance" "ser1" {
  ami = "ami-0453ec754f44f9a4a"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  subnet_id = aws_subnet.sub1.id
  key_name = "srikanth"
  user_data = base64encode(file("userdata.sh"))
}

resource "aws_instance" "ser2" {
  ami = "ami-0453ec754f44f9a4a"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  subnet_id = aws_subnet.sub2.id
  key_name = "srikanth"
  user_data = base64encode(file("userdata1.sh"))
}
#create alb
resource "aws_lb" "myalb" {
  name               = "myalb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.web-sg.id]
  subnets         = [aws_subnet.sub1.id, aws_subnet.sub2.id]

  tags = {
    Name = "web"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "myTG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.MyVpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}
resource "aws_lb_target_group_attachment" "attach1" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.ser1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach2" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.ser2.id
  port             = 80
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.myalb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type             = "forward"
  }
}

output "loadbalancerdns" {
  value = aws_lb.myalb.dns_name
}