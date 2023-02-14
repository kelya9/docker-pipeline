provider "aws" {

  region= var.region
}

resource "aws_ecr_repository" "registry" {
  name                 = var.aws_ecr_repository_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
