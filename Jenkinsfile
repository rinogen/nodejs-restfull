pipeline {
  agent any

  environment {
    MAKE_CMD = 'make'
  }

  stages {
    stage('Checkout') {
      steps {
        echo "Jalankan pipeline untuk branch main"
        checkout scm
      }
    }

    stage('Install Dependencies') {
      steps {
        sh 'docker --version'
        sh 'docker-compose --version'
      }
    }

    stage('Setup Environment File') {
      steps {
        withCredentials([file(credentialsId: 'env-prod-secret', variable: 'ENV_PROD_FILE')]) {
          sh 'cp "$ENV_PROD_FILE" .env.prod'
        }
      }
    }

    stage('Deploy') {
      steps {
        sh "${MAKE_CMD} prod-up"
      }
    }
  }

  when {
    branch 'main'
  }
}