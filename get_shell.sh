#!/bin/sh

adb shell am start -n com.example.point0/.MainActivity
sleep 3
adb shell input tap 500 700
sleep 1
adb shell input text $1
sleep 1
adb shell input tap 500 500
sleep 1
adb shell input text $2
sleep 1
adb shell input tap 400 600
