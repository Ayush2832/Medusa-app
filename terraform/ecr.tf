resource "aws_ecr_repository" "my_app_repo" {
  name = var.ecr_repo_name

  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    Name = var.ecr_repo_name
  }
}

resource "null_resource" "docker_build_and_push" {
  provisioner "local-exec" {
    command = <<EOT
      aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com

      docker build -t ${var.image_name} ..

      docker tag ${var.image_name}:latest ${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.ecr_repo_name}:v1

      docker push ${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.ecr_repo_name}:v1
    EOT
  }

  depends_on = [aws_ecr_repository.my_app_repo]
}