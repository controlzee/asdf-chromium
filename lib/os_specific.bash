#!/usr/bin/env bash

# export the os specific variables/commands

DOWNLOAD_PREFIX="Mac_Arm"
DOWNLOAD_FOLDER="chrome-mac"
DOWNLOAD_FILE_NAME="Chromium.app"
TOOL_TEST="chrome/Chromium.app/Contents/MacOS/Chromium --help"
# IS_ON_JENKINS="${JENKINS_USER}" # for now check if this is set

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	# linux -- probably jenkins?
	DOWNLOAD_PREFIX="Linux"
	DOWNLOAD_FOLDER="chrome-linux"
    DOWNLOAD_FILE_NAME="chrome"
	TOOL_TEST="chrome/chrome --help"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	# Mac OSX
	if [[ $(uname -m) == 'arm64' ]]; then
		DOWNLOAD_PREFIX="Mac_Arm"
	else
		DOWNLOAD_PREFIX="Mac"
	fi
	DOWNLOAD_FOLDER="chrome-mac"
    DOWNLOAD_FILE_NAME="Chromium.app"
	TOOL_TEST="chrome/Chromium.app/Contents/MacOS/Chromium --help" # go inside the mac app to run it!
elif [[ "$OSTYPE" == "cygwin" ]]; then
	# POSIX compatibility layer and Linux environment emulation for Windows
	DOWNLOAD_PREFIX="Win"
	DOWNLOAD_FOLDER="chrome-win"
    DOWNLOAD_FILE_NAME="chrome.exe"
    TOOL_TEST="chrome/chrome.exe --help"
elif [[ "$OSTYPE" == "msys" ]]; then
	# Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
	DOWNLOAD_PREFIX="Win"
	DOWNLOAD_FOLDER="chrome-win"
    DOWNLOAD_FILE_NAME="chrome.exe"
    TOOL_TEST="chrome/chrome.exe --help"
fi


export \
    TOOL_TEST \
    DOWNLOAD_PREFIX \
    DOWNLOAD_FOLDER \
    DOWNLOAD_FILE_NAME