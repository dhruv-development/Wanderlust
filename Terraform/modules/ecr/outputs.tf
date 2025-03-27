output "ecr_repo_url_frontend"{
  value = aws_ecr_repository.my_repository1.repository_url
}
output "ecr_repo_url_backend"{
  value = aws_ecr_repository.my_repository2.repository_url
}
