terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_cloudwatch_dashboard" "this" {
  dashboard_name = var.dashboard_name
  dashboard_body = var.dashboard_json
}
