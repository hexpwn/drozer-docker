############################
#
# latest Debian
# openjdk 11
# Android SDK 28
#
############################

FROM debian:latest
LABEL mantainer="https://twitter.com/hexpwn"

RUN useradd -ms /bin/bash drozer

# Install all dependencies
RUN apt-get update &&\
	apt-get -y install wget unzip &&\
	apt-get -y install python2.7 python-dev python-protobuf python-openssl python-twisted &&\
	apt-get -y install openjdk-11-jre-headless &&\
	apt-get clean &&\
	apt-get autoclean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /home/drozer

# Download and unpack Android SDK
RUN wget -qO /tmp/androidsdk.zip https://dl.google.com/android/repository/commandlinetools-linux-6514223_latest.zip &&\
	mkdir -p /opt/android/cmdline-tools &&\
	unzip -d /opt/android/cmdline-tools/ /tmp/androidsdk.zip &&\
	rm -rf /tmp/androidsdk.zip

# Create the necessary environment varialbes
ENV ANDROID_HOME /opt/android
ENV PATH $PATH:$ANDROID_HOME/cmdline-tools/tools/bin:$ANDROID_HOME/platform-tools

# Update and install Android SDK packages
RUN sdkmanager --update &&\
	# using 'yes' to auto-accept the license agreement
	yes | sdkmanager "platform-tools" "platforms;android-28"

# Switch to the user's home directory
WORKDIR /home/drozer

# Download the Drozer console
RUN wget "https://github.com/FSecureLABS/drozer/releases/download/2.4.4/drozer_2.4.4.deb"

# Install the Drozer console
RUN dpkg -i drozer_2.4.4.deb &&\
	rm *.deb

# Run as drozer user
USER drozer

# Download the Drozer agent
RUN wget "https://github.com/mwrlabs/drozer/releases/download/2.3.4/drozer-agent-2.3.4.apk"

# Update .bashrc
## Port forwarding required by drozer
RUN echo 'adb forward tcp:31415 tcp:31415' >> /home/drozer/.bashrc
## drozer command alias
RUN echo 'alias drozer="drozer console connect"' >> /home/drozer/.bashrc

