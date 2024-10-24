pipeline {
    agent any

    environment {
        MAVEN_HOME = tool 'Maven' // Ensure that Maven is configured in Jenkins Global Tools
        DOCKER_CREDENTIALS = credentials('docker-credentials-id') // Add your DockerHub credentials in Jenkins
        GIT_URL = 'https://github.com/username/my-java-app.git'
        SONAR_SERVER = 'http://localhost:9000' // Set this to your SonarQube server URL
        SONAR_TOKEN = 'your-sonar-token' // Your SonarQube token
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: "${GIT_URL}", branch: 'main'
            }
        }

        stage('Build with Maven') {
            steps {
                script {
                    sh "${MAVEN_HOME}/bin/mvn clean package"
                }
            }
        }

        stage('Run Unit Tests') {
            steps {
                script {
                    sh "${MAVEN_HOME}/bin/mvn test"
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    sh "${MAVEN_HOME}/bin/mvn sonar:sonar -Dsonar.projectKey=my-java-app -Dsonar.host.url=${SONAR_SERVER} -Dsonar.login=${SONAR_TOKEN}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t my-java-app:latest .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sh "echo ${DOCKER_CREDENTIALS_PSW} | docker login -u ${DOCKER_CREDENTIALS_USR} --password-stdin"
                    sh 'docker tag my-java-app:latest your-dockerhub-username/my-java-app:latest'
                    sh 'docker push your-dockerhub-username/my-java-app:latest'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}

