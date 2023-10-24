#!/usr/bin/env groovy

library identifier : 'jenkins-shared-library@main',retriever:modernSCM([
    $class:'GitSCMSource',
    remote:'https://github.com/Rahul-Kumar-Paswan/flask-shared-lib.git',
    credentialsId:'git-credentials'
])

pipeline {
  agent any
  
  stages{

    stage('Increment Version') {
      steps {
        script {
          echo " hello dear"
          def currentVersion = sh(
            script: "python3 -c \"import re; match = re.search(r'version=\\\\'(.*?)\\\\'', open('setup.py').read()); print(match.group(1) if match else '143')\"",
              returnStdout: true
              ).trim()

          echo "Previous Version: ${currentVersion}"
          // Split the version into major, minor, and patch parts
          def versionParts = currentVersion.split('\\.')

          // Access the version parts using index
          def major = versionParts[0]
          def minor = versionParts[1]
          def patch = versionParts[2]

          echo "Current Version: ${currentVersion}"
          echo "Major: ${major}"
          echo "Minor: ${minor}"
          echo "Patch: ${patch}"
          echo "old versionParts : ${versionParts}"
                    
          // Increment the patch part
          versionParts[-1] = String.valueOf(versionParts[-1].toInteger() + 1)
          echo "new versionParts : ${versionParts}"
                    
          // Join the version parts back together
          def newVersion = versionParts.join('.')
          echo "newVersion : ${newVersion}"
                    
          // Update the setup.py file with the new version
          sh "sed -i \"s/version='${currentVersion}'/version='${newVersion}'/\" setup.py"

          echo "New Version: ${newVersion}"
          env.IMAGE_NAME = "$newVersion-$BUILD_NUMBER"
          echo "New IMAGE_NAME: ${IMAGE_NAME}"
        }
      }
    }

    stage('Clean Build Artifacts') {
      steps {
        echo " hello dear welcome to  my world !!!!"
        sh 'rm -rf build/ dist/ *.egg-info/'
        echo " hello dear welcome to  my world !!!!"
        sh 'git status'
      }
    }
    
    stage('Build Image') {
      steps {
        echo "hello"
        /* sh "docker build -t flask_app:${IMAGE_NAME} ."
        sh "docker tag flask_app:${IMAGE_NAME} rahulkumarpaswan/flask_app:${IMAGE_NAME}"
        sh "docker push rahulkumarpaswan/flask_app:${IMAGE_NAME}" */

        buildImage "flask_app:${IMAGE_NAME}"
        dockerLogin()
        dockerPush "flask_app:${IMAGE_NAME}"
      }
    }

<<<<<<< HEAD
=======
    // stage("deploy") {
    //   steps {
    //     script {
    //       echo "Deploy to EC2........"
    //     }
    //   }
    // }

>>>>>>> 461affd (setting everything)
    stage("deploy") {
      steps {
        script {
          echo "Deploy to EC2........"
        }
      }
    }


    /* stage('Deploy') {
      steps {
        script {
          echo "Deploy to EC2........."
            def dockerCmd = "docker run -d --name rahul-project -p 3000:3000 rahulkumarpaswan/flask_app:${IMAGE_NAME}"
            sshagent(['ec2-user-Rahul']) {
                sh "ssh -o StrictHostKeyChecking=no ec2-user@13.232.90.226 ${dockerCmd}"//add ip address of EC2-docker instance 
            }
        }
      }
    } */


    
    stage("Git Commit Update") {
      steps {
        sh 'git config --global user.name "Rahul-Kumar-Paswan"'
        sh 'git config --global user.email "jekins@gmail.com"'

        sh 'git status'
        sh 'git branch'
        sh 'git config --list'

        sh 'git add .'
        sh 'git commit -m "cli: version updates"'
        withCredentials([gitUsernamePassword(credentialsId: 'git-token', gitToolName: 'Default')]) {
          sh 'git remote set-url origin https://github.com/Rahul-Kumar-Paswan/flask-jenkins.git'
          sh "git push origin HEAD:main"
        }
      }
    }


  }
}

// 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