# Functional Specification

## Context

Caddie is an application that will help golf players making better decisions when playing by. Caddie will also adapts its advice according to the level of the player to give the best experience to the user.

## Goal and Scope

The goal of the application is to help golf players to improve their level by giving them the best advice for each shot they have to make. The application will also keep track of the player's results and the distance he can send the ball with each club to give the best advice possible.

## Functional requirements

### Localization

The application will collect the localization of the user to adjust its advice in the function of the course. The localization will be used to know the distance between the player and the hole and to know the obstacles that are on the course.

### User data

The application will collect data on the user such as the distance he can send the ball to and his scores to adapt to the user level. The application will also keep track of the user's results to evaluate his level and give proper advice.

### Advice

The application will provide advice on where to aim and how far the player should try to go. The advice will be given by an algorithm that will take into account the distance between the player and the hole, the obstacles on the course and the level of the player.

### Rules

The application will provide all the rules and advice on what to do in each situation. The rules will be accesible through the official website of the R&A.

## Design

The application will be a mobile application that will be available on Android. The application will have a simple and intuitive interface to make it easy to use for everyone.

## Out of scope

Analysing the swing of the player by using the camera is not planned yet but is a possible improvement for the application.

Having the flag positions in real time is also not planned yet because it can change really often on certain course. However, by accessing a precise enough sattelite view, it would be possible to implement this feature.

Creating balls with sensors on them or putting sensors on other balls is also not planned. The main issues with those solutions are that the ball might not be balanced or not be up to standards anymore. The other issue is that if you do a bad shot and throw your ball in a lake or the woods, it may be impossible to recover them and it would cost a lot.

## Security

The localization of the user is only used on the device he used locally. The data about the user is also stored on the device and is not sent to any server.
