pipeline {
  agent { label 'jenkins-slave' }

  environment {
    DOCKER_IMAGE = 'mostafanwar/my-static-site:latest'
    TF_OUTPUT_PATH = "${env.HOME}/terraform_output.json"
  }

  stages {

    stage('Build and Push Docker Image') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'Docker-hub',
          usernameVariable: 'DOCKER_USER',
          passwordVariable: 'DOCKER_PASS'
        )]) {
          dir('node') {
            sh '''
              echo "$DOCKER_PASS" | sudo docker login -u "$DOCKER_USER" --password-stdin
              sudo docker build -t $DOCKER_IMAGE ./app
              sudo docker push $DOCKER_IMAGE
            '''
          }
        }
      }
      post {
        success {
          slackSend channel: '#jenkins', color: 'good', message: "✅ *Docker image built and pushed successfully:* `${env.JOB_NAME} #${env.BUILD_NUMBER}`"
        }
        failure {
          slackSend channel: '#jenkins', color: 'danger', message: "❌ *Failed to build/push Docker image:* `${env.JOB_NAME} #${env.BUILD_NUMBER}`"
        }
      }
    }

    stage('Run Ansible Playbook') {
      steps {
        dir('ansible') {
          sh 'ansible-playbook private-instances-playbook.yaml'
        }
      }
      post {
        success {
          slackSend channel: '#jenkins', color: 'good', message: "✅ *Ansible playbook executed successfully:* `${env.JOB_NAME} #${env.BUILD_NUMBER}`"
        }
        failure {
          slackSend channel: '#jenkins', color: 'danger', message: "❌ *Ansible playbook failed:* `${env.JOB_NAME} #${env.BUILD_NUMBER}`"
        }
      }
    }

    stage('Print Load Balancer DNS') {
      steps {
        script {
          if (!fileExists(env.TF_OUTPUT_PATH)) {
            error "Terraform output file not found: ${env.TF_OUTPUT_PATH}"
          }

          def tfOutput = readJSON file: env.TF_OUTPUT_PATH
          def dns = tfOutput['alb_dns_name']?.value

          if (!dns) {
            error "Could not extract DNS from Terraform output"
          }

          echo "App is running at: http://${dns}"
          env.LOAD_BALANCER_DNS = dns
        }
      }
      post {
        success {
          slackSend channel: '#jenkins', color: 'good', message: "✅ *Pipeline completed successfully!*\n🌐 App is live at: http://${env.LOAD_BALANCER_DNS}"
        }
        failure {
          slackSend channel: '#jenkins', color: 'danger', message: "❌ *Failed to retrieve Load Balancer DNS:* `${env.JOB_NAME} #${env.BUILD_NUMBER}`"
        }
      }
    }
  }
}
