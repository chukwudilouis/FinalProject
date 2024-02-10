pipeline {
    agent any
    stages {
        stage('compile') {
            steps {
                echo 'compiling..'
                git url: 'https://github.com/chukwudilouis/FinalProject.git'
                sh script: '/opt/maven/bin/mvn compile'
            }
        }
        stage('unit-test') {
            steps {
                echo 'unittest..'
                sh script: '/opt/maven/bin/mvn test'
            }
            post {
                success {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('package') {
            steps {
                echo 'package......'
                sh script: '/opt/maven/bin/mvn package'
            }
        }
    }
}
pipeline {
environment {
registry = "chukwudilouis/abctech"
registryCredential = 'Docker_2'
dockerImage = 'abctech'
}
agent any
stages {
stage('Cloning our Git') {
steps {
git 'https://github.com/chukwudilouis/FinalProject.git'
}
}
stage('Building our image') {
steps{
script {
dockerImage = docker.build registry + ":$BUILD_NUMBER"
}
}
}
stage('Deploy our image') {
steps{
script {
docker.withRegistry( '', registryCredential ) {
dockerImage.push()
}
}
}
}
stage('Cleaning up') {
steps{
sh "docker rmi $registry:$BUILD_NUMBER"
}
}
}
}
