FROM eclipse-temurin:11 as build
RUN git clone https://github.com/akuniutka/simple-http-server.git simple-http-server && \
    simple-http-server/mvnw -f simple-http-server/pom.xml
RUN $JAVA_HOME/bin/jlink \
    --add-modules java.base \
    --strip-debug \
    --no-man-pages \
    --no-header-files \
    --compress=2 \
    --output /javaruntime

FROM alpine:latest
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH "${JAVA_HOME}/bin:${PATH}"
COPY --from=build /javaruntime $JAVA_HOME
RUN mkdir /opt/http-server
COPY --from=build simple-http-server/target/simple-http-server-1.0-SNAPSHOT.jar /opt/simple-http-server/simple-http-server.jar
CMD ["java", "-jar", "/opt/simple-http-server/simple-http-server.jar"]

