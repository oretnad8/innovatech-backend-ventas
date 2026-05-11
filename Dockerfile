FROM maven:3.8.5-openjdk-17-slim AS build
WORKDIR /app

# Esto busca el pom.xml en cualquier subcarpeta y lo trae a la raíz de compilación
COPY . .

# Comando mágico: Busca donde esté el pom.xml y compila ahí
RUN mvn clean package -DskipTests -f $(find . -name pom.xml | head -n 1)

FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

# Esto busca el archivo .jar generado (no importa el nombre) y lo copia
COPY --from=build /app/**/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]