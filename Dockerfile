FROM ubuntu:latest

RUN apt-get update && apt-get install -y wget tar gzip && apt-get clean

RUN useradd -ms /bin/bash nonroot

COPY --chown=nonroot:nonroot ./ProjectMassivePackaged_MediaNight/Server/LinuxServer ./ProjectMassivePackaged/LinuxServer/
COPY --chown=nonroot:nonroot ProjectMassive.uproject ./

USER nonroot

EXPOSE 7777/udp
EXPOSE 7778/udp

CMD ["/bin/bash", "/ProjectMassivePackaged/LinuxServer/ProjectMassiveServer.sh"]
