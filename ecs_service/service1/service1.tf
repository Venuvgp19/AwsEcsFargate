variable "service_name" {
  description = "Name of the ECS service"
  type        = string
  default = "My-service"
}

variable "security_group_id" {
  type = string
}

variable "task_definition_arn" {
   type  = string
}

variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "desired_count" {
  description = "Desired count for the ECS service"
  type        = number
  default     = 2

}

resource "aws_ecs_service" "my_service" {
  name            = var.service_name
  cluster         = var.cluster_name
  task_definition = var.task_definition_arn
  launch_type     = "FARGATE"
  platform_version = "LATEST"  # Specify the desired platform version

  network_configuration {
    subnets = ["subnet-0a43907945aca543c"]  # Use the subnets from the ECS Task Module
    security_groups = [var.security_group_id]
    assign_public_ip = true
  }

  desired_count = var.desired_count
}

