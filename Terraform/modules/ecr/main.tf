resource "aws_ecr_repository" "my_repository1" {
  name                 = "${var.env}-${var.frontend_repo_name}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "my_repository2" {
  name                 = "${var.env}-${var.backend_repo_name}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
