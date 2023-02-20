# docker-pipeline 
This project is to setup a pipeline to deploy docker images in an ECR Repository using tools
like Jenkins, Git.
A webhook was also setup, so that each time there is a new commit in Git, Jenkins will
automatically trigger the image build and push it to ECR Repository

Installation

Prerequisites:

Docker installed locally
Git version: Latest
AWS cli and configured with IAM profile
Terraform used to deploy ECR repository
Jenkins server




