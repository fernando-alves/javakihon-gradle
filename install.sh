#!/usr/bin/env bash

# As seen on https://github.com/keeganwitt/docker-gradle/blob/9a3c8777938e62faa46e33e12ef34540a41d42b3/jdk8/Dockerfile
# But purposely doesnt have java

set -e

GRADLE_VERSION='3.5'

function download {
  wget --no-verbose --output-document=gradle.zip "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip"
}

function extract {
  unzip gradle.zip
}

function move_to_gradle_home {
  mv gradle-${GRADLE_VERSION} "${GRADLE_HOME}/"
}

function add_binary_to_path {
  ln --symbolic "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle
}

function run_wrapper {
  gradle wrapper
  ./gradlew
}

function stop_daemon {
  ./gradlew --stop
}

download
extract
move_to_gradle_home
add_binary_to_path
run_wrapper
stop_daemon
