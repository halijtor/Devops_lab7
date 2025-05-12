FROM maven:3.8.6-openjdk-17-slim AS builder
WORKDIR /build
COPY spring-backend/pom.xml .
RUN mvn dependency:go-offline -B
COPY spring-backend/src ./src
RUN mvn package -DskipTests -B
FROM openjdk:17-slim
RUN addgroup --system appuser && adduser --system --ingroup appuser appuser
WORKDIR /app
COPY --from=builder /build/target/*.jar app.jar
USER appuser
ENTRYPOINT ["java","-jar","app.jar"]

