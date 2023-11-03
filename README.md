[![CI][ci-img]][ci-url]
[![Discord][discord-img]][discord-url]
[![server pulls][docker-server-pulls-img]][docker-server-image-url]
[![version](https://img.shields.io/badge/Ubuntu-20.04-brown)](https://semver.org)
[![version](https://img.shields.io/badge/NodeJS--green)](https://semver.org)
[![version](https://img.shields.io/badge/JAVA-11-green)](https://semver.org)
[![version](https://img.shields.io/badge/Posrgres-11-blue)](https://semver.org)


# Class schedule
## Quick start ⚡
- [Application Diagram](#application-architecture-in-diagram)
- [For Developers](#instructions-for-developers-how-to-run-project-locally)
- [Run in Production](#instructions-how-to-deploy-project-in-production)
- [Partners](#partners-)
- 
## General info
This repository contains a source code of the Class Schedule Project.

The main goal of the project is designing a website where the university or institute staff will be able to create, store and display their training schedules.

Link to the development version of the site: https://develop-softserve.herokuapp.com/

## Application Architecture in Diagram
![schedule_application_architecturE.png](screenshots%2Fschedule_application_architecturE.png)

------------------------------------------
# Instructions for Developers (how to run Project locally)
Assuming that all commands will be running in shell from working directory
## Clone repository locally from Git
In order to create a local copy of the project you need:
1. Download and install the last version of Git https://git-scm.com/downloads
2. Open a terminal and go to the directory where you want to clone the files. 
3. Run the following command. Git automatically creates a folder with the repository name and downloads the files there.
```shell
git clone https://github.com/magyrka/devops-team-green && cd devops-team-green/
```
4. Enter your username and password if GitLab requests.

### Creating Your .env File with variables
```dotenv
FRONTEND_PORT=3000
BACKEND_PORT=8080
REDIS_PORT=6379
MONGO_PORT=27017
PG_PORT=5432

PG_PASSWORD=
DB_NAME=schedule
PG_USER=schedule
PG_DUMP_FILE='../backup/2023-09-07.dump'

```
### Export variables from .env 
```shell
source .env
```

### Create docker network
```shell
docker network create schedule_network
```


## Database PostgresQL
1. Run this simple commands to Start version 14 of PostgreSQL in Docker container
```shell
docker run -d --name postgresql \
	--network schedule_network \
	-v postgres-data:/var/lib/postgresql/data \
	-e POSTGRES_PASSWORD=$PG_PASSWORD \
	-e POSTGRES_DB=$DB_NAME \ 
	-e POSTGRES_USER=$PG_USER \
	-p 5432:5432 postgres:14
```
2. Restore PG data from file
```shell
docker cp $PG_DUMP_FILE postgresql:/tmp/backup.dump
docker exec -it postgresql psql -U $PG_USER -d $DB_NAME -f /tmp/backup.dump
docker exec -it postgresql psql -U $PG_USER -d $DB_NAME -c "CREATE DATABASE ${DB_NAME}_test WITH OWNER $PG_USER"
```
2. Configure connection url in `src/main/resources/hibernate.properties` and `src/test/resources/hibernate.properties` files:
```text
hibernate.connection.url=jdbc:postgresql://postgresql:5432/schedule
```
## Database Redis
1. Start the latest version of Redis in Docker container   
```shell
docker volume create redis-data
docker run -d --name redis 	-v redis-data:/data -p $REDIS_PORT:$REDIS_PORT redis 
```
2. Configure connection url in `src/main/resources/cache.properties` file:
```text
redis.address = redis://redis:6379
redis.address = redis://redis:${REDIS_PORT}
```

## Starting backend server using IntelliJ IDEA and Tomcat
1. Download and install the Ultimate version of IntelliJ IDEA (alternatively you can use a trial or EAP version) https://www.jetbrains.com/idea/download
2. Download and install Tomcat 9.0.50 https://tomcat.apache.org/download-90.cgi
3. Start the IDE and open class_schedule.backend project from the folder where you previously download it.
4. Make sure Tomcat and TomEE Integration is checked (`File –>> Settings –>> Plugins`).
5. `Run –>> Edit Configurations…`
6. Clicks `+` icon, select `Tomcat Server –>> Local`
7. Clicks on “Server” tab, then press `Configure...` button and select the directory with Tomcat server
8. Clicks on “Deployment” tab, then press `+` icon to select an artifact to deploy, and select `Gradle:com.softserve:class_schedule.war`
9. Press OK to save the configuration
10. `Run –>> Run 'Tomcat 9.0.50'` to start the backend server

## Starting frontend server using Node.js
1. Download and install Node.js 14.17.4 LTS version https://nodejs.org/en/
2. Open a terminal in `/frontend` directory of the downloaded project and run the following command.

       npm install
3. After the installation is finished run the following command to start the frontend server

       npm start


------------------------------------------
# Instructions how to deploy Project in Production

## For deploying this application  run this simple commands (on VM or Remote Server):
### Clone repostory
```shell
git clone https://github.com/magyrka/devops-team-green && cd devops-team-green/
```

### Run Docker compose file to start app
```shell
docker compose up -d -f docker-compose.prod.yaml
```
# Partners ❤️
## In the list, you can find collaborators, who was working in this project
- Developer Team:
   - Frontend team (incognito)
   - Backend team (incognito)
- Devops Team:
   - Vitaliy Kostyreva 
   - Vladyslav Manjirka
   - Valentyn Stratji
   - Liza Voievutska (Network support specialist)
   - Roman Hirnyak
