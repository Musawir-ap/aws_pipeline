# Products Inventory Management - CI/CD Pipeline

## Overview

This project automates the deployment of a **Maven-based Java web application** that manages product inventory, with **MySQL** as the backend database. The CI/CD pipeline is built using **Jenkins**, **Docker**, **Ansible**, and **Kubernetes (K3s)**. The goal is to streamline the entire development lifecycle, from code checkout to deployment on a Kubernetes cluster.

The application is tested, built, containerized, and deployed using Ansible playbooks to a Kubernetes cluster. Jenkins handles automation, while Docker is used for containerization.

## Project Architecture & Tools

The project flow is divided into the following key stages:
1. **Source Code Management**: GitHub is used for version control.
2. **Build and Test**: Maven is used to build and test the project.
3. **Containerization**: Docker is used to package the application into a container.
4. **Deployment**: Ansible deploys the application on Kubernetes (K3s).
5. **Continuous Integration & Delivery**: Jenkins automates the entire pipeline.

### Tools & Technologies
- **Jenkins**: For CI/CD automation.
- **GitHub**: Source code repository.
- **Maven**: For building and testing the Java web application.
- **Docker**: For containerizing the application.
- **Ansible**: For automating the deployment process.
- **Kubernetes (K3s)**: For orchestrating application containers.
- **MySQL**: Database for product data storage.

---

## Prerequisites

### Hardware/Software Requirements
- Jenkins server (running on RHEL or a similar system)
- Docker installed on the Jenkins server
- Kubernetes (K3s) cluster for deployment
- Ansible installed on Jenkins (or a node accessible by Jenkins)
- Kubernetes Python library installed (```pip install kubernetes```)

### Software Installation and Configuration

#### Install Required Tools on Jenkins Server
```bash
# Install Docker
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker

# Install Kubernetes Python library for Ansible
pip install kubernetes
```

#### Give Jenkins Access to Docker
```bash
# Add Jenkins user to the Docker group
sudo usermod -a -G docker jenkins
```

### Give Jenkins User Sudo Permission

To give the Jenkins user sudo permission, add the followng line to the sudoers file using `visudo` and add the following line:

```bash
jenkins ALL=(ALL) NOPASSWD: ALL
```

This is the recommended way to safely edit the sudoers file.

However, you can also achieve the same result programmatically by running the following command:

```bash
sudo sed -i '/^root\s\+ALL=(ALL)\s\+ALL/a jenkins ALL=(ALL) NOPASSWD: ALL' /etc/sudoers
```

---

## Setting up the CI/CD Pipeline

### Jenkins Plugins to Install
- **Git**: For source code management.
- **Maven Integration**: For building the Java application.
- **Docker Pipeline**: To integrate Docker into Jenkins jobs.
- **Ansible**: To run Ansible playbooks from Jenkins.
- **Workspace Cleanup**: To ensure a clean workspace before each build.

#### Steps to Install Plugins
1. Go to Jenkins dashboard.
2. Manage Jenkins -> Manage Plugins -> Available.
3. Search for the required plugins and install them:
   - Git
   - Maven Integration
   - Docker Pipeline
   - Ansible
   - Workspace Cleanup

---

## Project Setup

### Clone the Repository
```bash
git clone https://github.com/Musawir-ap/Products-pipeline.git
cd Products-pipeline
```

### Jenkinsfile Overview
```groovy
pipeline {
    agent { label 'abdul' }

    tools {
        maven "M3"
    }

    environment {
        // Define environment variables
        // ...
    }

    stages {
        // Checkout Source Code
        // Build and Test
        // Build Docker Image
        // Push to Docker Registry
        // Deploy with Ansible
    }

    post {
        success {
            echo 'Build and Deployment successful!'
        }

        failure {
            echo "Build Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
        }

        always {
            cleanWs()
        }
    }
}

```

### Ansible Playbooks and Inventory
- **Playbooks**: Located in `ansible/playbooks/deploy_k8s.yml`, used to deploy the Docker container to K3s.
- **Inventory**: Located in `ansible/inventory.ini`.

---

## Setting Up Jenkins Credentials

### Docker Registry Credentials
1. Navigate to **Jenkins Dashboard > Manage Jenkins > Manage Credentials**.
2. Add **DockerHub credentials** (username and password).
3. Store the credentials ID as `dockerhub-credentials-id` in Jenkins.

### Sudo Password
1. Add the Sudo password as a **secret text credential** in Jenkins.
2. Store the credentials ID as `SUDO_PASSWORD`.

---

## Kubernetes Setup

The application is deployed on a **K3s** Kubernetes cluster using Ansible playbooks. The deployment files for Kubernetes are located in the `k8s/` folder, which includes the following resources:
- **ConfigMaps**
- **Deployments**
- **Persistent Volume Claims (PVC)**
- **Secrets**
- **Services**

---

## GitHub Webhook Setup for CI/CD

To trigger Jenkins builds from GitHub, set up a webhook:
1. Navigate to your GitHub repository's **Settings > Webhooks**.
2. Add a new webhook pointing to your Jenkins server.
   - Payload URL: `http://<your-jenkins-url>/github-webhook/`

### SocketXP for Public URL Testing

If your Jenkins is running on localhost, you can use **SocketXP** to expose it to the public:
1. Install SocketXP:
   ```bash
   curl -s https://www.socketxp.com/install.sh | sudo bash
   ```
2. Generate a public URL:
   ```bash
   socketxp connect http://localhost:8080
   ```
   Use the generated URL as the GitHub webhook URL.

---

## How to Run the Project

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Musawir-ap/Products-pipeline.git
   ```

2. **Install Dependencies**:
   - Install required Jenkins plugins.
   - Configure Docker, Ansible, and Kubernetes.
   - Set up credentials in Jenkins for Docker and Sudo.

3. **Set up Jenkins Pipeline**:
   - Create a new pipeline project in Jenkins.
   - Use the provided `Jenkinsfile` for the pipeline configuration.
   - Trigger the pipeline manually or through GitHub webhooks.

---

## Project Directory Structure

```
Products-pipeline/
├── ansible/
│   ├── inventory.ini
│   └── playbooks/
│       └── deploy_k8s.yml
├── Dockerfile
├── Jenkinsfile
├── k8s/
│   ├── configmaps/
│   ├── deployments/
│   ├── pvc/
│   ├── secrets/
│   └── services/
├── pom.xml
├── src/
│   └── main/
│       ├── java/
│       └── webapp/
└── README.md
```

## Project Flow

```
+-----------------------------+
| Start: Code in GitHub Repo   |
+-------------+---------------+
              |
              v
+-----------------------------+
| Checkout Source Code         |
| Jenkins: Pull from GitHub    |
+-------------+---------------+
              |
              v
+-----------------------------+
| Build & Test using Maven     |
| Jenkins: mvn clean package   |
| Jenkins: mvn test            |
+-------------+---------------+
              |
              v
+-----------------------------+
| Build Docker Image           |
| Jenkins: docker build        |
+-------------+---------------+
              |
              v
+-----------------------------+
| Push to Docker Registry      |
| Jenkins: docker push         |
+-------------+---------------+
              |
              v
+-----------------------------+
| Deploy with Ansible          |
| Run Ansible playbook         |
| ansible-playbook deploy_k8s.yml |
+-------------+---------------+
              |
              v
+-----------------------------+
| Kubernetes Deployment        |
| Deploy services to K3s       |
+-------------+---------------+
              |
              v
+-----------------------------+
| Monitoring Setup             |
| Prometheus & Grafana         |
+-------------+---------------+
              |
              v
+-----------------------------+
| End: Application Running     |
| & Monitored in Kubernetes    |
+-----------------------------+

```

## Final Notes

This project automates the full deployment lifecycle of a Maven-based Java web application, with Jenkins orchestrating the CI/CD process. Docker, Ansible, and Kubernetes work together to ensure reliable containerization and deployment to the K3s cluster.