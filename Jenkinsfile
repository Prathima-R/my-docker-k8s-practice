pipeline {
    agent any

    environment {
        IMAGE_NAME = "babugudageri/django-ecom"
    }

    stages {

        stage('Git Checkout') {
            steps {
                echo "📦 Cloning the repository"
                git branch: 'main', url: 'https://github.com/BasavarajGudageri-05/Django-ecommerce-application.git'
            }
        }

        stage('Docker Build') {
            steps {
                echo "🐳 Building Docker image"
                sh "docker build -t $IMAGE_NAME:latest ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo "🚀 Pushing image to Docker Hub"
                withCredentials([usernamePassword(credentialsId: 'credentialsid', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USER')]) {
                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $IMAGE_NAME:latest
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo "⚙️ Deploying to Kubernetes"
                withKubeConfig(
                    credentialsId: 'kubecredID'
                ) {
                    sh '''
                        echo "Applying Deployment..."
                        kubectl apply -f Deployment.yml
                        echo "Applying Service..."
                        kubectl apply -f Service.yml
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Kubernetes deployment successful"
        }
        failure {
            echo "❌ Deployment failed, check Jenkins logs"
        }
    }
}
