pipeline {
    agent any

    stages {
        stage("increment version") {
            steps {
                script {
                    dir("app") {
                        echo "incrementing version..."
                        def metadata = readJSON file: 'package.json'
                        def metadataAsList = metadata["version"].split("\\.")
                        echo metadataAsList
                        // def major = metadataAsList[0]
                        // def minor = metadataAsList[1]
                        // def patch = metadataAsList[2]
                        // // echo metadata["version"]
                        // echo "major: ${major}"
                        // echo "minor: ${minor}"
                        // echo "patch: ${patch}"
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