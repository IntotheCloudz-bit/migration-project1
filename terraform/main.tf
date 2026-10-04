module "ec2" {
  source = "git::https://github.com/IntotheCloudz-bit/terraform-ec2-modules.git//ec2"

  key_name           = "KEY-Pair_Cloudz"
  subnet_id = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.web_sg.security_group_id]
  name               = "migration-ec2"
}

module "vpc" {
  source = "git::https://github.com/IntotheCloudz-bit/terraform-ec2-modules.git//vpc"

  name = "migration-vpc"
}

module "web_sg" {
  source = "git::https://github.com/IntotheCloudz-bit/terraform-ec2-modules.git//SG"

  name   = "migration-web-sg"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [
    {
      description = "SSH from my current public IP"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [local.my_ip_cidr]
    },
    {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}