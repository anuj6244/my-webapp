pipeline {
    agent any

    tools {
        maven 'Maven 3.8.6' // Make sure you set up Maven in Jenkins global tools
    }

    stages {
        stage('Checkout') {
            steps {
                // Pull the latest code from Git
                git 'https://github.com/yourusername/mywebapp.git' // Replace with your repo URL
            }
        }

        stage('Build') {
            steps {
                // Build the project using Maven
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                // Run unit tests
                sh 'mvn test'
            }
        }

        stage('Docker Build') {
            steps {
                // Build the Docker image
                sh 'docker build -t mywebapp:latest .'
            }
        }

        stage('Deploy') {
            steps {
                // Deploy the container
                sh '''
                    docker stop mywebapp || true
                    docker rm mywebapp || true
                    docker run -d -p 80:8080 --name mywebapp mywebapp:latest
                '''
            }
        }
    }
}