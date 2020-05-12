FROM openjdk:8-alpine

RUN mkdir minecraft
WORKDIR minecraft

EXPOSE 25565
ENTRYPOINT java -Xmx3G -Xms1G -jar server.jar nogui
