# Stage 1: Build frontend files
FROM node:20-alpine AS frontend_build
WORKDIR /react-app/
COPY frontend /react-app/
RUN npm install
RUN npm run build

# Stage 2: Build the Java Gradle application
FROM gradle:7.3-jdk11 AS gradle_build
WORKDIR /java-app
COPY . /java-app/
COPY --from=frontend_build /react-app/build/assets /java-app/src/main/webapp/assets
COPY --from=frontend_build /react-app/build/static /java-app/src/main/webapp/static
COPY --from=frontend_build /react-app/build/. /java-app/src/main/webapp/WEB-INF/view
RUN rm -rf /java-app/src/main/webapp/WEB-INF/view/assets \
    && rm -rf /java-app/src/main/webapp/WEB-INF/view/static
RUN gradle build -x test

# Stage 3: Deploy war on Tomcat9
FROM tomcat:9-jre11
COPY --from=gradle_build /java-app/build/libs/class_schedule.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]