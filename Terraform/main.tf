module "ecr" {
  source           = "./modules/ecr"
  env 		   = "dev"
  frontend_repo_name = "frontend"
  backend_repo_name  = "backend"
}

module "vpc" {
  source               = "./modules/vpc"
  vpc_name             = "wanderlust-vpc"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidr_1 = "10.0.1.0/24"
  public_subnet_cidr_2 = "10.0.3.0/24"
  public_subnet_cidr_3 = "10.0.4.0/24" 
  private_subnet_cidr  = "10.0.2.0/24"
  availability_zone1   = "us-east-2a"
  availability_zone2   = "us-east-2b"
  availability_zone3   = "us-east-2c"
  env                  = "dev"
}

module "ecs" {
  source                  = "./modules/ecs"
  cluster_name            = "Wanderlust"
  service_name            = "Wanderlust-service"
  task_family             = "Wanderlust-task"
  aws_region 		  = "us-east-2"
  vpc_id                  = module.vpc.vpc_id
  public_subnet_ids       = module.vpc.public_subnet_ids
  private_subnet_id       = module.vpc.private_subnet_id
  load_balancer_sg_id     = module.vpc.load_balancer_sg_id
  ecs_frontend_sg_id      = module.vpc.ecs_frontend_sg_id
  ecs_backend_sg_id       = module.vpc.ecs_backend_sg_id
  ecr_repo_url_frontend   = module.ecr.ecr_repo_url_frontend
  ecr_repo_url_backend    = module.ecr.ecr_repo_url_backend
}
