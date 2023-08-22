# Project Massive

<br>
<br>

---

## Table of Contents

---

<br>

- [Description](#description)
- [Installation/ Startup](#installation)
- [Contributing](#contributing)
- [Authors/ Acknowledgements](#acknowledgements)

<br>

## <!-- DESCRIPTION -->

## Description

---

Project Massive is a third-person, massive-multiplayer online, playground, UE5 game prototype. Players can interact with the game world and each other.
The backend runs one server instance to which all players are connected. For the proof of concept of the Softwareproject, this server was hosted on a scalable Kubernetes Cluster on the Google-Cloud. You can host the server wherever you like, the easiest way is just on your local host machine.

<br>
<br>

## <!-- INSTALLATION -->

## Installation

---
>> As Github has major difficulties in handling large binary files this project was created with Perforce, i decided to publish it nevertheless on Github too and worked around the upload issues via the following link to my Cloud directory. 
In order to function properly you have to download the `ProjectMassivePackaged_MediaNight` and `ProjectMassivePackaged_runWithoutDocker` folders from the Cloud: https://cloud.mi.hdm-stuttgart.de/s/rsAEkMZfz3JHBww

<br>

### Start: Game without Server

If you want to start the Prototypes Client executable without connecting to a server you just have to doublicklick the `ProjectMassive.exe` located in `ProjectMassivePackaged_runWithoutDocker/Windows`.

<br>

### Start: Local Server on your machine

- When you just want to host the Server on your local windows machine without Docker, navigate to `ProjectMassivePackaged_runWithoutDocker/WindowsServer` and run:
 > `$ ./ProjectMassiveServer.exe -log`

- If you want to set up a Server hosted in a local Kubernetes Cluster and connect to it, make sure to follow the instructions of the `KubernetesReadme.md`.

- If you want to set up a Server hosted in a local Docker Container follow these instructions:
 
  - make sure that Docker Desktop is installed and running
 
  - also make sure that the file `ProjectMassiveServer.sh` located in `ProjectMassivePackaged_MediaNight/Server/LinuxServer` has UNIX file endings. Either use the dos2unix command or you can use VS code and choose the line endings in the bottom right corner. It should be set to "LF" instead of "CRLF" before you build your container Image. (Notepad++ works aswell Edit > EOL Conversion > Unix)
  - open console in `ProjectMassive_Final` root and run:
    > `$ docker compose up` 

<br> 

- If Docker Compose is not working you can start die Server manually: 
 > `$ docker build -t unreal_server .` 

<br> 

 > `$ winpty docker run -p 7777:7777/udp -p 7778:7778/udp -it unreal_server`

 - to exit close server log

<br>

### Connect: Client to your local Server

To start one or more game instances and connect to the local server, run the ProjectMassive.exe Client executable (which one belongs to your preferred Server host method) with following args:
  > `$ ./ProjectMassive.exe 127.0.0.1:7777 -WINDOWED -ResX=800 -ResY=450`
- to exit press ALT + F4


<br>
<br>

---

## Controls

---

- `W/A/S/D` move character
- `SPACE` to jump
- `LMB` once: grab and hold object | twice: release object | when click on another player the character is been pushed away
- `RMB` throw grabbed object
- `ENTER` once: to open chat | twice: to commit message and close chat

<br>
<br>

---


## <!-- CONTRIBUTING -->

## Contributing

---

Project Massive was developed with the Unreal Engine 5 Editor *Sourcecode Build release version 5.2.0* as a Desktop project using Blueprints.
The Game Server was hosted on a Kubernetes Cluster on Google-Cloud.

<br>
<br>

## <!-- ACKNOWLEDGEMENTS -->

## Acknowledgements

---

This prototype was developed by Bianca Knülle, Tim Drobny and Manuel Danze
as a Software Project, over a period of 4 months, in the 4th Semester of Computer Science Media at the Hochschule der Medien Stuttgart. The Final Prototype was presented at the Media Night 06/29/2023.

---
