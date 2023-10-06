resource "aws_ecs_cluster" "my_cluster" {
  name = "my-ecs-cluster" # Specify the name of your ECS cluster
}

output clustern_name {
  value = aws_ecs_cluster.my_cluster.name
}
