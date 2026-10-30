
module "vpc" {
  source = "./modules/vpc"

  vpc_name             = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones

  tags = {
    Environment = var.environment
    Project     = "Reusable-AWS-Terraform"
    ManagedBy   = "Terraform"
  }
}

module "web_security_group" {
  source = "./modules/security-group"

  security_group_name = "${var.vpc_name}-web-sg"
  description         = "Security group for web servers"
  vpc_id              = module.vpc.vpc_id

  ingress_rules = [
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

  egress_rules = [
    {
      description = "Outbound HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Environment = var.environment
    Project     = "Reusable-AWS-Terraform"
    ManagedBy   = "Terraform"
  }
}



module "monitoring" {
  source = "./modules/monitoring"

  alarm_name    = "enterprise-${var.environment}-cpu-alarm"
  instance_id   = module.ec2.instance_id
  cpu_threshold = 80

  tags = {
    Environment = var.environment
    Project     = "Reusable-AWS-Terraform"
    ManagedBy   = "Terraform"
  }
}


module "ec2" {
  source = "./modules/ec2"

  instance_name      = "enterprise-${var.environment}-web"
  instance_type      = var.instance_type
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.web_security_group.security_group_id]

  root_volume_size = var.root_volume_size

  tags = {
    Environment = var.environment
    Project     = "Reusable-AWS-Terraform"
    ManagedBy   = "Terraform"
  }
}


