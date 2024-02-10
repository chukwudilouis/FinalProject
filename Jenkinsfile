pipeline {
    agent { label 'slave' }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from the Git repository
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/chukwudilouis/FinalProject.git']]])
            }
        }

        stage('Compile') {
            steps {
                // Compile the Java code using Maven
                sh 'mvn compile'
            }
        }

        stage('Test') {
            steps {
                // Run tests using Maven
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                // Package the application using Maven
                sh 'mvn package'
            }
        }
    }

    post {
        success {
            // Additional actions to perform on success (e.g., deployment)
            echo 'Build successful! Perform additional deployment steps here.'
        }
        failure {
            // Actions to perform on failure
            echo 'Build failed! Notify or take corrective actions here.'
        }
    }
}
