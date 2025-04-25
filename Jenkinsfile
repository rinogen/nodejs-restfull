pipeline {
  agent any

  environment {
    MAKE_CMD = 'make'
  }

  stages {
    stage('Checkout') {
      when {
        branch 'main'
      }
      steps {
        echo "Jalankan pipeline untuk branch main"
        checkout scm
      }
    }

    stage('Install Dependencies') {
      when {
        branch 'main'
      }
      steps {
        sh 'docker --version'
        sh 'docker-compose --version'
      }
    }

    stage('Setup Environment File') {
      when {
        branch 'main'
      }
      steps {
        withCredentials([file(credentialsId: 'env-prod-secret', variable: 'ENV_PROD_FILE')]) {
          sh 'cp "$ENV_PROD_FILE" .env.prod'
        }
      }
    }

    stage('Deploy') {
      when {
        branch 'main'
      }
      steps {
        sh "${MAKE_CMD} prod-up"
      }
    }

    stage('Prisma Generate') {
      when {
        branch 'main'
      }
      steps {
        sh 'docker-compose --env-file .env.prod -f docker-compose.prod.yml exec api-prod npx prisma generate'
      }
    }
  }
}