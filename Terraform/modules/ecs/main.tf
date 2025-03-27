data "aws_iam_role" "ecs_task_execution_role" {
  name = "ECSTaskExecution-role"
}

resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
  tags = {
    Name = "${var.cluster_name}"
  }
}

resource "aws_lb" "app_lb" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.load_balancer_sg_id]
  subnets            = var.public_subnet_ids 

  enable_deletion_protection = false
  tags = {
    Name = "dev-wanderlust-alb"
  }
}

resource "aws_lb_target_group" "frontend_tg" {
  name       = "frontend-tg"
  port       = 5173
  protocol   = "HTTP"
  vpc_id     = var.vpc_id
  target_type = "ip"

  health_check {
    path     = "/src/main.tsx"
    protocol = "HTTP"
    port     = "5173"
    matcher  = "200"
  }

  tags = {
    Name = "frontend-tg"
  }
}

resource "aws_lb_target_group" "backend_tg" {
  name       = "backend-tg"
  port       = 5000
  protocol   = "HTTP"
  vpc_id     = var.vpc_id
  target_type = "ip"

  health_check {
    path     = "/health"
    protocol = "HTTP"
    port     = "5000"
    matcher  = "200"
  }

  tags = {
    Name = "backend-tg"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_lb.arn
  port                = 80
  protocol            = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }

  tags = {
    Name = "dev-load-balancer-http-listener"
  }
}

resource "aws_lb_listener_rule" "backend_rule" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}

resource "aws_cloudwatch_log_group" "backend" {
  name              = "/ecs/${var.task_family}-backend"
  retention_in_days = 7

  tags = {
    Environment = "dev"
  }
}

resource "aws_cloudwatch_log_group" "frontend" {
  name              = "/ecs/${var.task_family}-frontend"
  retention_in_days = 7

  tags = {
    Environment = "dev"
  }
}

resource "aws_ecs_task_definition" "frontend" {
  family                  = "${var.task_family}-frontend"
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = 256
  memory                  = 512
  execution_role_arn      = data.aws_iam_role.ecs_task_execution_role.arn

  container_definitions = <<DEFINITION
[
  {
    "name": "wanderlust-frontend",
    "image": "${var.ecr_repo_url_frontend}",
    "portMappings": [
      {
        "containerPort": 5173,
        "hostPort": 5173
      }
    ],
    "essential": true,
    "environment": [
      { "name": "VITE_API_PATH", "value": "https://www.codematrix.space" }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${aws_cloudwatch_log_group.frontend.name}",
        "awslogs-region": "${var.aws_region}",
        "awslogs-stream-prefix": "ecs-frontend"
      }
    }
  }
]
DEFINITION

  tags = {
    Name = "${var.task_family}-frontend"
  }

  depends_on = [aws_lb.app_lb]
}

resource "aws_ecs_task_definition" "backend" {
  family                  = "${var.task_family}-backend"
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = 256
  memory                  = 512
  execution_role_arn      = data.aws_iam_role.ecs_task_execution_role.arn

  container_definitions = <<DEFINITION
[
  {
    "name": "wanderlust-backend",
    "image": "${var.ecr_repo_url_backend}",
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 5000
      }
    ],
    "essential": true,
    "environment": [
      { "name": "MONGODB_URI", "value": "mongodb+srv://dhruv:uczASn7YJVnke7Bb@wanderlust.pfdev.mongodb.net/wanderlust?retryWrites=true&w=majority&appName=Wanderlust" }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${aws_cloudwatch_log_group.backend.name}",
        "awslogs-region": "${var.aws_region}",
        "awslogs-stream-prefix": "ecs-backend"
      }
    }
  }
]
DEFINITION

  tags = {
    Name = "${var.task_family}-backend"
  }
  depends_on = [aws_lb.app_lb]
}

resource "aws_ecs_service" "frontend" {
  name            = "${var.service_name}-frontend"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.frontend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [var.private_subnet_id]
    security_groups = [var.ecs_frontend_sg_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.frontend_tg.arn
    container_name   = "wanderlust-frontend"
    container_port   = 5173
  }

  tags = {
    Name = "${var.service_name}-frontend"
  }
  depends_on = [aws_lb.app_lb, aws_lb_target_group.frontend_tg]
}

resource "aws_ecs_service" "backend" {
  name            = "${var.service_name}-backend"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.backend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [var.private_subnet_id]
    security_groups = [var.ecs_backend_sg_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.backend_tg.arn
    container_name   = "wanderlust-backend"
    container_port   = 5000
  }

  tags = {
    Name = "${var.service_name}-backend"
  }
  depends_on = [aws_lb.app_lb, aws_lb_target_group.backend_tg]
}
