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

        // stage("test") {
        //     steps {
        //         script {
        //             echo "running unit tests..."
        //             sh "npm run test"
        //         }
        //     }
        // }

        // stage("build image") {
        //     steps {
        //         script {
        //             echo "building image..."
        //             sh "npm package"
        //         }
        //     }
        // }

        // stage("push image to nexus") {
        //     steps {
        //         script {
        //             echo "pushing image to nexus..."
        //         }
        //     }
        // }

        // stage("commit version increment") {
        //     steps {
        //         script {
        //             echo "committing version increment..."
        //         }
        //     }
        // }
    }
}