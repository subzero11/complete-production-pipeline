FROM maven:3.9.0-eclipse-temurin-17 AS build

# Install curl
RUN apt-get update && apt-get install -y curl

WORKDIR /app
COPY . .

# Test connection to Maven repository
RUN curl -I https://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-starter-parent/3.0.4/spring-boot-starter-parent-3.0.4.pom

RUN mvn clean install

FROM eclipse-temurin:17.0.6_10-jdk
WORKDIR /app
COPY --from=build /app /app
