pipeline {
    agent any 
    parameters { choice(name: 'Environment', choices: ['staging', 'qa1', 'prod','preprod'], description: 'Select the Environment to run the test')
                 choice(name: 'Testing', choices: ['Sanity', 'Regression'], description: 'Select the testing type to run the test') }

    stages {
        stage('Clean') { 
            steps {
                bat "echo hello Clean"
                cleanWs notFailBuild: true
            }
        }
        stage('checkout') { 
            steps {
                bat "echo hello checkout"
                checkout([$class: 'GitSCM', branches: [[name: '*/API_Automation_Karate']], extensions: [], userRemoteConfigs: [[url: 'git@github.com:Koredotcom/CucumberUIAutomation.git']]])         }
        }
        stage('Build') { 
            steps {
                bat "echo hello Build"
                bat 'mvn clean compile'
            }
        }
        stage('Test') { 
            steps {
                bat "echo Test"
                bat 'mvn -P %Environment%,%Testing% test'
            }
        }
    }
    post {
        always {
            junit 'target/surefire-reports/*.xml'
            cucumber buildStatus: 'null', customCssFiles: '', customJsFiles: '', failedFeaturesNumber: -1, failedScenariosNumber: -1, failedStepsNumber: -1, fileIncludePattern: '**/*.json', jsonReportDirectory: 'target/surefire-reports', pendingStepsNumber: -1, reportTitle: 'Test Cucumber report', skippedStepsNumber: -1, sortingMethod: 'ALPHABETICAL', undefinedStepsNumber: -1


        bat "echo Done!"
			emailext subject: "Job '${env.JOB_NAME} - ${env.BUILD_NUMBER}:${currentBuild.currentResult}'", body: 'Refer to the Attachement', attachmentsPattern:'Karate/target/karate-reports/karate-summary.html', to: 'vishnuprasath.ramanujam@kore.com'
            }
        }
}
