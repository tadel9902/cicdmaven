FROM openjdk:8
EXPOSE 8080
ADD target/dockerimgpush.jar dockerimgpush.jar
ENTRYPOINT ["java","-jar","/dockerimgpush.jar"]