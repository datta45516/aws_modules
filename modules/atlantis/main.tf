terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_ecs_task_definition" "atlantis" {
  family                   = "atlantis"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"
  execution_role_arn       = var.execution_role_arn
  container_definitions    = <<DEFINITION
[
  {
    "name": "atlantis",
    "image": "ghcr.io/runatlantis/atlantis:latest",
    "portMappings": [{ "containerPort": 4141 }],
    "environment": [
      { "name": "ATLANTIS_GH_USER", "value": "${var.gh_user}" },
      { "name": "ATLANTIS_GH_TOKEN", "value": "${var.gh_token}" }
    ]
  }
]
DEFINITION
}

resource "aws_ecs_service" "atlantis" {
  name            = "atlantis"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.atlantis.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = true
  }
}
