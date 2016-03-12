# WATCHOS2 Titanium Sample App

This is a simple test app showing communication between a Titanum iOS app and a watch OS2 app. The idea is that you can send chat messages to the app where it will either automatically reply with a random message or a message reply can be selected from a provided list.


I have used the Watch Session userInfo comms as I could not get the sendMessage option working (I even tried to AppC demo app and the sendMessage option would not work), but the goal here was just to prove to myself I could get a simple app up and running.


My swift code for the watch app is probably no where near best parctices, but it does work (for me anyway)


## About
This project was created and edited using Sublime Text 3 (and a few custom plugin I have written) and only uses the Ti CLI to run and test. The command line I use for running in the sim's is:

**ti build -p ios --log-level info --device-id --launch-watch-app**

The only thig I did was to use XCode and set up a phone sim with a watch sim for testing.




