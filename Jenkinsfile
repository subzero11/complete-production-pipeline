pipeline{
    agent{
        label "jenkins-agent"
    }
    tools{
        jdk 'Java17'
        maven 'Maven3'
    }
    environment{
	    APP_NAME = "complete-production-pipeline"
	    RELEASE = "1.0.0"
	    DOCKER_USER = "newguyinli"
	    DOCKER_PASS = "dockerhub"
	    IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
    }
    stages{
        stage('Clean Workspace'){
            steps{
                cleanWs()
            }
            }
        stage('Checkout from SCM'){
            steps{
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/subzero11/complete-production-pipeline'
            }
        }
        stage('Build Application'){
            steps{
                sh "mvn clean package"
            }
        }
        stage('Test Application'){
            steps{
                sh "mvn test"
            }
        }
         stage('Sonarqube Analysis'){
            steps{
		script{
		    withSonarQubeEnv(credentialsId: 'jenkins-sonarqube-token'){
                	sh "mvn sonar:sonar"
				}
        		}
		}
        }
         stage('Quality Gate'){
            steps{
		script{
		    waitForQualityGate abortPipeLine: false, credentialsId: 'jenkins-sonarqube-token'
        		}
		}
        }
	    
    }
}
