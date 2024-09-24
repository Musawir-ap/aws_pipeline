pipeline {
    agent { label 'abdul' }

    tools {
        maven "M3"
    }

    environment {
        DOCKER_REGISTRY = 'devmusawir'
        DOCKER_IMAGE = 'products-app'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials-id'
        ANSIBLE_PLAYBOOK_PATH = 'ansible/playbooks/deploy_k8s.yml'
        ANSIBLE_INVENTORY_PATH = 'ansible/inventory.ini'
        GIT_REPO_URL = 'https://github.com/Musawir-ap/Products-pipeline.git'
        SUDO_PASSWORD = credentials('SUDO_PASSWORD')
    }

    stages {
        stage('Checkout Source Code') {
            steps {
                git branch: 'main', url: "${env.GIT_REPO_URL}"
            }
        }

        stage('Build and Test') {
            steps {
                script {
                    sh 'mvn clean package' 
                    sh 'mvn test' 
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${env.DOCKER_REGISTRY}/${env.DOCKER_IMAGE}:latest")
                }
            }
        }

        stage('Push to Docker Registry') {
            steps {
                script {
                    docker.withRegistry('', "${env.DOCKER_CREDENTIALS_ID}") {
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Deploy with Ansible') {
            steps {
                ansiblePlaybook(
                    playbook: "${env.ANSIBLE_PLAYBOOK_PATH}",
                    inventory: "${env.ANSIBLE_INVENTORY_PATH}",
                    extraVars: [
                            ansible_become_pass: "${SUDO_PASSWORD}" 
                        ],
                    extras: '-v'
                )
            }
        }
    }

    post {
        success {
            echo 'Build and Deployment successful!'
        }

        failure {
            script {
                // emailext subject: "Build Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                //         body: "Build #${env.BUILD_NUMBER} has failed. Check the logs: ${env.BUILD_URL}",
                //         to: 'youremail@example.com'
                echo "Build Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
            }
        }

        always {
            cleanWs()
        }
    }
}
