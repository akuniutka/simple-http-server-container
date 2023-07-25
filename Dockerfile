FROM eclipse-temurin:11 as build
RUN apt update && \
    apt -y install git && \
    git clone https://github.com/akuniutka/simple-http-server.git simple-http-server && \
    simple-http-server/mvnw -f simple-http-server/pom.xml clean package && \
    mkdir /opt/simple-http-server && \
    cp simple-http-server/target/simple-http-server-1.0-SNAPSHOT.jar /opt/simple-http-server/simple-http-server.jar
CMD ["java", "-jar", "/opt/simple-http-server/simple-http-server.jar"]

