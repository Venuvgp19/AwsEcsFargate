resource "aws_iam_policy" "Myecs_execution_policy" {
  name        = "ECSPolicy"
  description = "Policy for ECS tasks"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role" "Myecs_execution_role" {
  name = "MYECSExecutionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "ecs_execution_policy_attachment" {
  name         = "ECSExecutionPolicyAttachment"
  policy_arn   = aws_iam_policy.Myecs_execution_policy.arn
  roles        = [aws_iam_role.Myecs_execution_role.name]
}

output ecsrolearn {
  value = aws_iam_role.Myecs_execution_role.arn
}
