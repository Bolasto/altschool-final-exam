# altschool-final-exam
This repo contains files and codes for my final project in AltSchool of Cloud Engineering.

Executive Summary

A Single react app and Socks app deployment on Amazon EKS using Terraform as the configuration management tool and Helm charts to help manage Kubernetes applications on ArgoCD using both Prometheus and Gafara as monitoring tools with a CI/CD pipeline also with GitHub Actions. 

Requirement/Necessity 

	Github Account
	NPM (Not package Manager)/ NodeJS
	Docker
	Terraform
	Helm charts
	AWS Account
	AWS CLI
	K8s(Kubernetes)
	Github Actions
	ArgoCD

Infrastructure/Automation Deployment

The main objective of this project is to deploy two applications, React App & socks shop with Kubernetes using an IAC tool. The Infrastructure as Code tool used was Terraform. Terraform was used to configure files alongside executing and managing them continuously. 
	Clone a simple React App and edit.
	Create a new GitHub repository and push the code to the repository.
	Create a new GitHub Actions file.  
	Create a new secret in the GitHub repository with GHCR username and password.
	The image name in the docker file must be correct for a successful dockerization.
	Create a new AWS account and create a new user.
	Configure the AWS CLI with the new user credentials.
	Create a new S3 bucket for the terraform state.
	Configure the terraform backend in the main.tf.
	Terraform initialization.
	Terraform plan & plan.
	eks.tf terraform file creates EKS cluster &the node group.
	argocd-apps.tf will create argocd deployment.

The deployment yamls located in the /my-argocd-app/ directory will create the react app, the socks app and the monitoring stack (Prometheus and grafana) using helm only for the monitoring stacks.

The end result appears like the screenshot below on my argoCD. 
![image](https://user-images.githubusercontent.com/105098138/226182952-21f3079f-3e12-4c0e-b86d-c10ed824b451.png)
