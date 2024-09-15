pipeline {
    agent any

    tools {
        maven "Maven-3.9.9"
    }


    environment {
        DOCKER_REGISTRY = 'docker.io/your-dockerhub-username'
        DOCKER_IMAGE = 'your-app-name'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials-id'
        ANSIBLE_PLAYBOOK_PATH = '/path/to/your/ansible/playbook.yml'
        ANSIBLE_INVENTORY_PATH = '/path/to/your/ansible/inventory'
        GIT_REPO_URL = 'https://github.com/Musawir-ap/Products-pipeline.git'
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
                    sh 'mvn clean package' // Build the Maven project
                    sh 'mvn test' // Run unit tests
                }
            }
        }

        // stage('Build Docker Image') {
        //     steps {
        //         script {
        //             sh "docker build -t ${env.DOCKER_REGISTRY}/${env.DOCKER_IMAGE}:latest ."
        //         }
        //     }
        // }

        // stage('Push to Docker Registry') {
        //     steps {
        //         script {
        //             docker.withRegistry('https://index.docker.io/v1/', "${env.DOCKER_CREDENTIALS_ID}") {
        //                 sh "docker push ${env.DOCKER_REGISTRY}/${env.DOCKER_IMAGE}:latest"
        //             }
        //         }
        //     }
        // }

        // stage('Deploy with Ansible') {
        //     steps {
        //         script {
        //             sh """
        //                 ansible-playbook -i ${env.ANSIBLE_INVENTORY_PATH} ${env.ANSIBLE_PLAYBOOK_PATH} \
        //                 -e docker_image=${env.DOCKER_REGISTRY}/${env.DOCKER_IMAGE}:latest
        //             """
        //         }
        //     }
        // }

        // stage('Send Email Notification') {
        //     steps {
        //         script {
        //             emailext subject: "Build Successful: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
        //                     body: "Good job! Build #${env.BUILD_NUMBER} was successful. View it here: ${env.BUILD_URL}",
        //                     to: 'youremail@example.com'
        //         }
        //     }
        // }
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
                echo 'Build Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}'
            }
        }

        always {
            cleanWs() // Clean up workspace after build
        }
    }
}
