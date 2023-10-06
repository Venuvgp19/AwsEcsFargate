variable "MyExecutionRoleArn" {
  type = string
}

variable "security_group_ids" {
  description = "List of security group IDs for the task"
  type        = list(string)
}

resource "aws_ecs_task_definition" "my_task" {
  family = "My-task"

  network_mode = "awsvpc"  # Fargate requires the "awsvpc" network mode
  requires_compatibilities = ["FARGATE"]
  cpu = "256"
  memory = "512"
  execution_role_arn = var.MyExecutionRoleArn
  task_role_arn = var.MyExecutionRoleArn

  container_definitions = jsonencode([
    {
      name  = "my-container"
      image = "318884730776.dkr.ecr.ap-southeast-1.amazonaws.com/sriram:latest"
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ],
      log_configuration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group" = "/ecs/my-container-logs"
          "awslogs-region" = "us-east-1"  # Change to your AWS region
          "awslogs-stream-prefix" = "ecs"
        }
      },
      network_mode = "awsvpc"
      network_configuration = {
        security_groups = [var.security_group_ids]
        subnets = ["subnet-0a43907945aca543c"]
      }
    },
  ])
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.my_task.arn
}
