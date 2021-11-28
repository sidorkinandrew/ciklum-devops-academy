Final Task for Academy

 

The final task for DevOps Academy students:

The task's description in general.

Deploy IaC Infrastructure in AWS Cloud using Terraform and create CI/CD in Jenkins to deploy a dockerized web application.

The detailed description:

Use your AWS credentials and your Subnet. (Subnet name = your Surname \ login)
IaC. Use Terraform to deploy: EC2 Instance (Application Server), EC2 Instance (Jenkins Master), ALB, Record Route53 (DNS name), ECR (The registry to store Docker Images), RDS (the database for an application); Use GitLab your private repository to store the Terraform code. Repository name should consist of your last name and _final_task. Example Fedoran_final_task.
Add output for each resource if it’s needed.

Each student should use the ‘creator’ tag with the Name as value. Example of Tag Creator: Sochyvets

Use ‘user data’ AWS feature to install all packages on application server and on Jenkins server

Required: Use terraform for main components (EC2, RDS, ALB, ECR), but integration\configuration might be done manually

 

CI/CD. Setup Jenkins Master. Create Jenkins Job to build and deploy the application. You can use declarative or scripted pipeline syntax. Jenkinsfile should be stored in the same repository as for Terraform.  CI/CD should consist of these stages:
●       checkout SCM;

●       docker build;

●       docker push to the private Container Registry (ECR) created in the previous step;

●       deploy the application on the Application Server (EC2) created in the previous step; In this stage Jenkins Job should connect to the Application Server and run application on instance.  Use docker commands or docker-compose file to run your image(s) on the Application Server.

Application. Web site on WordPress. Use RDS as a Database. CI/CD should show changes in the web site.
 

Naming Conventions:

Jenkins server name: jenkins-{student’s-surname}

Application server name: application-{student’s-surname}