# Drozer docker container

**UPDATED: 2020-jun-01**

Docker container for Android analysis with Drozer (https://github.com/FSecureLABS/drozer)

* Latest Debian
* Openjdk 11
* Android SDK 28
* Drozer 2.4.4

## Installation
```
git clone https://github.com/hexpwn/drozer-docker.git
cd drozer-docker
docker build drozer .
chmod +x start.sh
```

## Running

1. Connect your Android phone via USB to your host machine.

2. Run `./start.sh` to start the container.

*You may be asked by your phone to authorize USB debugging.*

**If you have not previously installed the Drozer Agent**, inside the docker image run:
```
adb install drozer-agent-2.3.4.apk
```
4. Start the Drozer Agent app on your phone and turn the Embedded Server **ON**

5. Start drozer with command `drozer`

