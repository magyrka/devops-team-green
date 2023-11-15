pipeline {
    agent any

    environment {
        POSTGRES_CREDS = credentials('postgres-creds')
        APP_NAME = "schedule_app"
        // postgres
        PG_DUMP_FILE = "backup/2023-09-07.dump"
        PG_CONTAINER_NAME = "postgresql"
        PG_DB_NAME = "schedule"
        USER_NAME = "$POSTGRES_CREDS_USR"
        USER_PASS = "$POSTGRES_CREDS_PSW"
        // mongo
        MONGO_DB_NAME = "mongodb"
        MONGO_CONTAINER_NAME = "mongodb"
        // redis
        REDIS_CONTAINER_NAME = "redis"
        // ports
        PG_PORT = 5432
        REDIS_PORT = 6379
        MONGO_PORT = 27017
        TOM_PORT = 8082
    }

    stages {
        stage('Cleanup') {
            steps {
                script {
                    sh 'docker stop $PG_CONTAINER_NAME $MONGO_CONTAINER_NAME $REDIS_CONTAINER_NAME $APP_NAME  || true'
                    sh 'docker rm $PG_CONTAINER_NAME $MONGO_CONTAINER_NAME $REDIS_CONTAINER_NAME $APP_NAME  || true'
                    sh 'docker volume rm -f postgres-data mongo-data || true'
                }
            }
        }

        stage('Checkout') {
            steps {
                script {
                    def gitRepoUrl = 'git@github.com:magyrka/devops-team-green-2.git'
                    def gitBranch = 'Staging'
                    def gitCredentialsId = 'schedule-github-ssh'

                    // sh 'ssh -T git@github.com'
                    checkout([$class: 'GitSCM', branches: [[name: "${gitBranch}"]], userRemoteConfigs: [[url: "${gitRepoUrl}", credentialsId: "${gitCredentialsId}"]]])
                    sh 'cp .env-sample .env'
                }
            }
        }


        stage('Test') {
            steps {
                sh 'docker run -d --name postgresql_test \
                    -e POSTGRES_USER=$USER_NAME \
                    -e POSTGRES_PASSWORD=$USER_PASS \
                    -p $PG_PORT:$PG_PORT postgres:14-alpine'
                sh 'docker run -d --name mongodb_test \
                    -p $MONGO_PORT:$MONGO_PORT \
                    mongo:7.0-rc-jammy'
                sh 'chmod +x ./gradlew'
                sh './gradlew test'
            }
            post {
                always {
                    // Remove the testdb container
                    sh 'docker stop postgresql_test mongodb_test'
                    sh 'docker rm postgresql_test mongodb_test'
                }
            }
        }

        stage('Build') {
            steps {
                sh 'docker network create --driver bridge schedule_network || true'
                sh 'docker volume create postgres-data'
                sh 'docker run -d --name $PG_CONTAINER_NAME \
                    --network schedule_network \
                    -v postgres-data:/var/lib/postgresql/data \
                    -e POSTGRES_PASSWORD=$USER_PASS \
                    -e POSTGRES_DB=$PG_DB_NAME \
                    -e POSTGRES_USER=$USER_NAME \
                    postgres:14-alpine'
                sh 'sleep 10'
                sh 'docker cp $PG_DUMP_FILE $PG_CONTAINER_NAME:/tmp/backup.dump'
                sh 'docker exec $PG_CONTAINER_NAME psql -U $USER_NAME -d $PG_DB_NAME -f /tmp/backup.dump'
                sh 'docker volume create mongo-data'
                sh 'docker run -d --network schedule_network \
                    --name $MONGO_CONTAINER_NAME \
                    -v mongo-data:/data/db mongo:7.0-rc-jammy'
                sh 'docker run -d --network schedule_network \
                    --name $REDIS_CONTAINER_NAME redis:7-alpine'
                sh 'docker build -t schedule_app_img --progress plain --no-cache .'
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker run -d --network schedule_network \
                    --name $APP_NAME \
                    --env-file .env \
                    -e USER_PASS=$USER_PASS \
                    -p $TOM_PORT:8080 schedule_app_img'
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}