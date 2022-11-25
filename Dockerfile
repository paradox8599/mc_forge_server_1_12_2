FROM anapsix/alpine-java

WORKDIR /root/mc

ENV FORGE_INSTALLER_ADDR=https://maven.minecraftforge.net/net/minecraftforge/forge/1.12.2-14.23.5.2859/forge-1.12.2-14.23.5.2859-installer.jar
ENV FORGE_INSTALLER_NAME=forge-1.12.2-14.23.5.2859-installer.jar
ENV SERVER_FILE_NAME=forge-1.12.2-14.23.5.2859.jar

RUN apk update
RUN apk add aria2

# Download Forge installer
RUN aria2c $FORGE_INSTALLER_ADDR -o $FORGE_INSTALLER_NAME
# Install mc forge server
RUN java -jar $FORGE_INSTALLER_NAME --installServer
# Remove installer
RUN rm forge-*-installer*

# Agree EULA
RUN echo "eula=true" > eula.txt

CMD ["java", "-Xmx20G", "-Xms20G", "-jar", "forge-1.12.2-14.23.5.2859.jar", "nogui"]
