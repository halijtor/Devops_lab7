FROM maven:3.8-openjdk-17-slim AS builder
WORKDIR /app
COPY spring-backend/pom.xml .
COPY spring-backend/src ./src
RUN mvn -B package -DskipTests

FROM openjdk:17-slim
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
ENV SERVER_PORT=8080
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]

