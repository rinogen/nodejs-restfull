pipeline {
  agent any

  environment {
    MAKE_CMD = 'make'
    ENV_DEV = credentials('env-dev-secret')   // file untuk dev
    ENV_PROD = credentials('env-prod-secret') // file untuk prod
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
            echo "Generate file .env.prod dari Jenkins Credentials"
            writeFile file: '.env.prod', text: "${ENV_PROD}"
          } else if (env.BRANCH_NAME == 'dev') {
            echo "Generate file .env.dev dari Jenkins Credentials"
            writeFile file: '.env.dev', text: "${ENV_DEV}"
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
  }
}
