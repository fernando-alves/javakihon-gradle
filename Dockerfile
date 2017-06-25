FROM ubuntu:16.04

RUN apt-get update && \
apt-get install -y wget unzip openjdk-8-jdk && \
apt-get clean

RUN groupadd --system --gid 1000 gradle && \
useradd --system --gid gradle --uid 1000 --shell /bin/bash --create-home gradle && \
chown --recursive gradle:gradle /home/gradle

ENV GRADLE_HOME /opt/gradle
ENV GRADLE_USER_HOME /home/gradle

COPY gradleWrapper /tmp

RUN sh /tmp/gradlew
