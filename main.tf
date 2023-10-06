provider "aws" {
  region = "ap-southeast-1" # Specify your desired AWS region
}

module iam {
  source = "./iam/"
}

module ecs_cluster {
  source = "./ecs_cluster"
}

module security_group {
  source = "./security_group"
}

module ecs_task {
  source = "./ecs_task"
  MyExecutionRoleArn = module.iam.ecsrolearn
  security_group_ids =  [module.security_group.security_group_id]
}

module ecs_service_1 {
  source = "./ecs_service/service1"
  task_definition_arn = module.ecs_task.task_definition_arn
  cluster_name = module.ecs_cluster.clustern_name
  security_group_id = module.security_group.security_group_id
}

module ecs_service_2 {
  source = "./ecs_service/service2"
  task_definition_arn = module.ecs_task.task_definition_arn
  cluster_name = module.ecs_cluster.clustern_name
  security_group_id = module.security_group.security_group_id

}

output clustername {
  value = module.ecs_cluster.clustern_name
}

output taskdefArn {
  value = module.ecs_task.task_definition_arn

}
