pipeline {
  agent any

  environment {
    AWS_REGION   = 'us-east-2'
    AWS_ACCOUNT  = '942010118414'
    ECR_REGISTRY = "${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com"
    ECR_REPO     = "${ECR_REGISTRY}/dev-aws"
    CLUSTER_NAME = 'eks-cluster'
    RELEASE_NAME = 'dev-aws'
    IMAGE_TAG    = "latest"
  }

  stages {
    stage('Checkout Code') {
      steps { checkout scm }
    }

    stage('Build Docker Image') {
      steps {
        sh '''
          docker build -t $ECR_REPO:$IMAGE_TAG -t $ECR_REPO:latest ./app
        '''
      }
    }

    stage('Push to ECR') {
      steps {
        sh '''
          aws sts get-caller-identity
          aws ecr get-login-password --region $AWS_REGION | \
          docker login --username AWS --password-stdin $ECR_REGISTRY

          docker push $ECR_REPO:$IMAGE_TAG
          docker push $ECR_REPO:latest
        '''
      }
    }

    stage('Deploy to EKS') {
      steps {
        sh '''
          aws sts get-caller-identity
          aws eks update-kubeconfig --region $AWS_REGION --name $CLUSTER_NAME

          helm upgrade --install $RELEASE_NAME ./helm/dev-aws \
            --set image.repository=$ECR_REPO \
            --set image.tag=$IMAGE_TAG
        '''
      }
    }
  }

  post {
    success { echo "✅ Deployment successful!" }
    failure { echo "❌ Deployment failed!" }
  }
}