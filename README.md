# aws-ecs-jenkins
Jenkins stack on Amazon ECS with EFS


### Deploy cluster

Creates VPC Configuration, EFS and mountpoints and ECS Cluster

```bash
cd cfn
aws cloudformation create-stack --stack-name jenkins-ecs-vpc --template-body "$(<cluster.yml)"
```

### Deploy ecs stack (Services, Tasks, ELBs, instances)

```bash
tools/deploy-services.sh --cluster-stack-name jenkins-ecs-vpc
```

### Update services and tasks

#### Stopping manually services and instances to limit costs

```bash
cd cfn
aws cloudformation update-stack \
--stack-name jenkins-ecs-stack \
--template-body "$(<cfn/jenkins.yml)" \
--parameters \
  ParameterKey=ECSJenkinsServiceCount,ParameterValue=0 \
  ParameterKey=ECSProxyServiceCount,ParameterValue=0 \
  ParameterKey=ASGDesiredInstances,ParameterValue=0 \
--capabilities CAPABILITY_IAM
```

### Jenkins Slaves images
