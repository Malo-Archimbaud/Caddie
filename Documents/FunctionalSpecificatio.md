# Functional Specification

## Context

Caddie is an application that will help golf players making better decisions when playing by. It will also help improving their level by analysing their score and give feedbaack on what to work on. Caddie will also adapts its advice according to the level of the player to give the best experience to the user

## Goal and Scope

The goal is to create an app that will help golf players improve. The app will be divided with different functionalities:

- The main one, which is tracking the position of the player and propose a the next shot. For that, the app should have access to the localisation, but use a minimal percentage of battery. The app should be able to tell how long the player walk to the ball and propose the next shot to the remaining distance. The app will also be able to adjust its advice depending on previous shots.
- The next feature will be the score storage. Any game played should be available to one year prior. This will allow to see how he evolved and where he has difficulties.
- The next one is the training one. The user will be able to give his best distance with each kind of clubs. Then, the app will be able to refine the calcuclations to find teh best shot in every situation
- The last one is the rule book. The app have all the rules to date to allow the user to ask the app if he needs reminder. The app will also be able to give the best solution according to the situation.

## Functional requirements

## Acceptance criteria

## Design

## Non functional requirements

## Out of scope

Analysing the swing of the player by using the camera is not planned yet but is a possible improvement for the application.

Having the flag positions in real time is also not planned yet because it can change really often on certain course. However, by accessing a precise enough sattelite view, it would be possible to implement this feature.

Creating balls with sensors on them or putting sensors on other balls is also not planned. The main issues with those solutions are that the ball might not be balanced or not be up to standards anymore. The other issue is that if you do a bad shot and throw your ball in a lake or the woods, it may be impossible to recover them and it would cost a lot.

## Security

The only kind of sensitive data that would be stored is the golf course played. All the localisation processing will be done locally. To protect the player privacy, an asymetric encryption algorithm is planned.

## Glossary

- club: what is used to propel the ball in golf