FROM maven:3.9-eclipse-temurin-17 AS build
COPY . /petclinic
WORKDIR /petclinic
RUN mvn package


FROM eclipse-temurin:17-alpine
LABEL project="learning" 
LABEL author="khaja"
ARG USERNAME=spc
RUN adduser -D -h /apps -s /bin/sh ${USERNAME}
USER ${USERNAME}
COPY --from=build  --chown=${USERNAME}:${USERNAME}  /petclinic/target/spring-petclinic-3.4.0-SNAPSHOT.jar /apps/spring-petclinic-3.4.0-SNAPSHOT.jar
WORKDIR /apps
EXPOSE 8080
# CMD Executes when the container is started
CMD [ "java", "-jar", "spring-petclinic-3.4.0-SNAPSHOT.jar" ]