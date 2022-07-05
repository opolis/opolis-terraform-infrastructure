terraform {
  required_version = ">= 1.2.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.37"
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE AWS LOG GROUP
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_cloudwatch_log_group" "log_group" {
  name              = var.name
  retention_in_days = var.retention
}

