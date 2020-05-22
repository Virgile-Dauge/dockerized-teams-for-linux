- [Usage](#org52517fa)
- [Pourquoi](#orgbabebb0)
- [Dockerfile](#orgc8920e6)



<a id="org52517fa"></a>

# Usage

! Ne support pas encore les webcams !

```bash
docker run --rm -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY --device /dev/snd/ teams:latest
```


<a id="orgbabebb0"></a>

# Pourquoi

Le nombre de réunions à explosé en raison du confinement et nombre de réunions/soutenances sont (déraisonnablement?) proposées sous l'outil Microsoft Teams.

Or, il n'est pas possible de l'utiliser correctement sous Firefox, il est nécessaire d'installer le client lourd.

Bien qu'il existe une version Linux officielle, je tiens à garder pour moi l'ensemble des données présentes sur ma machine.

C'est pourquoi j'ai bricolé de quoi lancer "teams-for-linux" dans un container docker.

teams-for-linux est un client teams non officiel dispo ici : <https://github.com/IsmaelMartinez/teams-for-linux>


<a id="orgc8920e6"></a>

# Dockerfile

```dockerfile
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
```
