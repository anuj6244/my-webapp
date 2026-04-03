pipeline {
    agent any

    tools {
        jdk 'jdk17'       // Name you gave JDK 17 in Jenkins
        maven 'maven'     // Name you gave Maven 3.8.6
    }

    environment {
        DOCKER_IMAGE = "yourdockerhubusername/my-webapp:latest"
        DOCKER_CREDENTIALS = "dockerhub-creds"
    }

    stages {
        stage('Check Java') {
    steps {
        sh 'java -version'
        sh 'javac -version'
    }
}
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'git@github.com:anuj6244/my-webapp.git',
                    credentialsId: 'github-ssh'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Docker Build') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${dockerhub-creds}",
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying Docker image ${DOCKER_IMAGE}"
                // Add your deploy commands here
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo "Pipeline succeeded!"
        }
        failure {
            echo "Pipeline failed!"
        }
    }
}
