output "repository_url" {

  value = aws_ecr_repository.registry.repository_url

}

output "repository_name" {

  value = aws_ecr_repository.registry.arn

}

output "repository_id" {
    value = aws_ecr_repository.registry.id
  
}
