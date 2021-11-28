resource "aws_ecr_repository" "app-sidorkin" {
  name = "app-sidorkin"


  tags = {
    Name = "ECR-Registry-Sidorkin",
    Creator = "Sidorkin"
  }

}