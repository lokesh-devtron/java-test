# -------- Build Stage --------
ARG JVM_VERSION=17

FROM eclipse-temurin:${JVM_VERSION}-jdk AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN java -version
RUN javac -version

RUN mkdir -p target
RUN javac -d target src/main/java/App.java

# -------- Runtime Stage --------
FROM eclipse-temurin:${JVM_VERSION}-jre

WORKDIR /app

COPY --from=build /app/target .

CMD ["java", "App"]
