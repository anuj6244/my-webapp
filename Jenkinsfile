pipeline {
    agent any

    tools {
        maven 'maven 3.8.6'
    }

    environment {
        IMAGE_NAME = "dockerhubuser/mywebapp"
        TAG = "${BUILD_NUMBER}"
        CONTAINER_NAME = "mywebapp"
        DEPLOY_SERVER = "azureuser@DEPLOY_SERVER_IP"
    }

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/yourusername/mywebapp.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$TAG .'
            }
        }

        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh '''
                        echo $PASS | docker login -u $USER --password-stdin
                        docker push $IMAGE_NAME:$TAG
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sshagent(['deploy-server-ssh']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no $DEPLOY_SERVER '
                        docker pull $IMAGE_NAME:$TAG &&
                        docker stop $CONTAINER_NAME || true &&
                        docker rm $CONTAINER_NAME || true &&
                        docker run -d -p 80:8080 --name $CONTAINER_NAME $IMAGE_NAME:$TAG
                    '
                    """
                }
            }
        }
    }
}
