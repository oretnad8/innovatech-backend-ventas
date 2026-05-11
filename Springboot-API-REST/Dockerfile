# Etapa 1: Build con Maven
FROM maven:3.8.5-openjdk-17-slim AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

# Etapa 2: Runtime ligero
FROM openjdk:17-jdk-alpine
# Seguridad: Crear usuario no root
RUN addgroup -S devops && adduser -S devops -G devops
USER devops
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]