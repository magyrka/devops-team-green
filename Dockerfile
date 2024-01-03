# Stage 1: Build the Java Gradle application
FROM gradle:7.3-jdk11 AS gradle_build
WORKDIR /java-app
COPY . /java-app/
RUN gradle build -x test --no-watch-fs

# Stage 2: Deploy war on Tomcat9
FROM tomcat:9-jre11
COPY --from=gradle_build /java-app/build/libs/class_schedule.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
