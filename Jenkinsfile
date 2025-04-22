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
