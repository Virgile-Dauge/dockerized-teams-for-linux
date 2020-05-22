FROM ubuntu:20.04

ENV VERSION 1.0.4
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y wget gdebi

RUN wget https://github.com/IsmaelMartinez/teams-for-linux/releases/download/v${VERSION}/teams-for-linux_${VERSION}_amd64.deb

RUN gdebi --non-interactive teams-for-linux_${VERSION}_amd64.deb

RUN useradd -m teams
RUN usermod -a -G audio teams
USER teams
ENTRYPOINT [ "teams-for-linux" ]
