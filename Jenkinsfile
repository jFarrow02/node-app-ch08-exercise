pipeline {
    agent any

    environment {
        NEW_VERSION = ""
        NEW_IMAGE = ""
        ARTIFACT_REPO = "54.242.242.46"
        ARTIFACT_REPO_PORT = "8083"
    }
    stages {
        stage("increment version") {
            steps {
                script {
                    dir("app") {
                        echo "incrementing version..."
                        def metadata = readJSON file: 'package.json'
                        def versionAsList = metadata["version"].split("\\.")
                        def appName = metadata["name"]
                        
                        def major = versionAsList[0]
                        def minor = versionAsList[1]
                        def patch = versionAsList[2]

                        def incremented = Integer.parseInt(minor)
                        incremented++

                        NEW_VERSION = "${major}.${incremented}.${patch}"
                        sh "npm version ${NEW_VERSION}"
                        NEW_IMAGE = "${ARTIFACT_REPO}:${ARTIFACT_REPO_PORT}/${appName}:${NEW_VERSION}"

                        echo "NEW_IMAGE: ${NEW_IMAGE}"
                    }
                }
            }
        }

        stage("test") {
            steps {
                script {
                    dir("app") {
                        echo "installing dependencies..."
                        sh 'npm install'
                        echo "running unit tests..."
                        sh "npm run test"
                    }
                    
                }
            }
        }

       stage("build image") {
            steps {
                script {
                    echo "building image..."
                    withCredentials([usernamePassword(credentialsId: "nexus-creds", usernameVariable: "USR", passwordVariable: "PWD")]) {
                        sh "docker build -t $NEW_IMAGE ."
                        sh "echo $PWD | docker login -u $USR --password-stdin $ARTIFACT_REPO:$ARTIFACT_REPO_PORT"
                        sh "docker push $NEW_IMAGE"
                    }
                }
            }
        }


        stage("commit version bump") {
            steps {
                script {
                    echo "committing version bump..."
                    withCredentials([
                        usernamePassword(credentialsId: "github-creds-jFarrow02", usernameVariable: "USR", passwordVariable: "PWD"),
                        string(credentialsId: "exercise08-accesstoken", variable: "TKN")
                        ]) {
                        // def repoUrl = "github.com/jFarrow02/node-app-ch08-exercise.git"
                        def repoUrlWithAuth = "https://${USR}:${auth-token}@github.com/${USR}/jFarrow02/node-app-ch08-exercise.git"
                        sh "git config --global user.email 'jack.dempsey.farrow@gmail.com'"
                        sh "git config --global user.name 'Jenkins Admin'"

                        // sh "git remote set-url origin https://${USR}:${PWD}@github.com/jFarrow02/node-app-ch08-exercise.git"
                        // sh "git remote set-url origin https://github.com/${USR}/jFarrow02/node-app-ch08-exercise.git"
                        sh "git remote set-url origin https://${USR}:${TKN}@github.com/${USR}/jFarrow02/node-app-ch08-exercise.git"
                        sh "git add ."
                        sh 'git commit -m"ci: version bump"'
                        sh "git push origin HEAD:${BRANCH_NAME}"
                    }
                }
            }
        }
    }
}