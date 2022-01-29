pipeline {
    agent any

    stages {
        stage("increment version") {
            steps {
                script {
                    echo "incrementing version..."
                }
            }
        }

        stage("test") {
            steps {
                script {
                    echo "running unit tests..."
                }
            }
        }

        stage("build image") {
            steps {
                script {
                    echo "building image..."
                }
            }
        }

        stage("push image to nexus") {
            steps {
                script {
                    echo "pushing image to nexus..."
                }
            }
        }

        stage("commit version increment") {
            steps {
                script {
                    echo "committing version increment..."
                }
            }
        }
    }
}