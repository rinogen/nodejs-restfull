pipeline {
  agent any

  environment {
    MAKE_CMD = 'make'
  }

  stages {
    stage('Checkout') {
      steps {
        echo "Jalankan pipeline untuk branch: ${env.BRANCH_NAME}"
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
        script {
          if (env.BRANCH_NAME == 'main') {
            withCredentials([file(credentialsId: 'env-prod-secret', variable: 'ENV_PROD_FILE')]) {
              sh 'cp "$ENV_PROD_FILE" .env.prod'
            }
          } else if (env.BRANCH_NAME == 'dev') {
            withCredentials([file(credentialsId: 'env-dev-secret', variable: 'ENV_DEV_FILE')]) {
              sh 'cp "$ENV_DEV_FILE" .env.dev'
            }
          } else {
            echo "Branch ${env.BRANCH_NAME} tidak butuh file .env"
          }
        }
      }
    }

    stage('Deploy') {
      steps {
        script {
          if (env.BRANCH_NAME == 'main') {
            sh "${MAKE_CMD} prod-up"
          } else if (env.BRANCH_NAME == 'dev') {
            sh "${MAKE_CMD} dev-up"
          } else {
            echo "Branch ${env.BRANCH_NAME} tidak didukung untuk deploy."
          }
        }
      }
    }

    stage('Prisma Generate') {
      steps {
        script {
          if (env.BRANCH_NAME == 'main') {
            sh 'docker-compose --env-file .env.prod -f docker-compose.prod.yml exec api-prod npx prisma generate'
          } else if (env.BRANCH_NAME == 'dev') {
            sh 'docker-compose --env-file .env.dev -f docker-compose.dev.yml exec api-dev npx prisma generate'
          }
        }
      }
    }
  }
}
