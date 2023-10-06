# Functional Specification

## Context

Caddie is an application that will help golf players making better decisions when playing by. It will also help improving their level by analysing their score and give feedbaack on what to work on. Caddie will also adapts its advice according to the level of the player to give the best experience to the user

## Goal and Scope

The goal is to create an app that will help golf players improve. The app will be divided with different functionalities:

- The main one, which is tracking the position of the player and propose a the next shot. For that, the app should have access to the localisation, but use a minimal percentage of battery. The app should be able to tell how long the player walk to the ball and propose the next shot to the remaining distance. The app will also be able to adjust its advice depending on previous shots.
- The next feature will be the score storage. Any game played should be available to one year prior. This will allow to see how he evolved and where he has difficulties.
- The next one is the training one. The user will be able to give his best distance with each kind of clubs. Then, the app will be able to refine the calcuclations to find the best shot in every situation
- The last one is the rule book. The app have all the rules to date to allow the user to ask the app if he needs reminder. The app will also be able to give the best solution according to the situation.

## Functional requirements

The app will be able to locate the user's position. The app will be able to detect a stop when the player is walking to his ball. It will be then able to calculate the distance reached with the shot, what is the current score of the player and what is his next best possible shot.

The app will also be able to save the scores the user did on each hole of a course, the total score and where did the user play.

The app will also be able to refine his recommandations via training session. The user will enter the distance he can do with each club. After every game played, calculation will be done to always refine what the user is capable of, and thus given more and more correct estimation.

The app will also be able to provide solution if the user is not sure of the exact rule that should be applied in a specific scenario. Given the situation the user is in, the app will do the best choice among the different possibilities.

## Acceptance criteria

- The app should be able to locate the user within one meter
- The app should not use 50% of the battery in a golf game within 5%
- The app should not be more than 100 Mo

## Design

A white background with greenish tones is envisaged as default. The white background is the best choice since the app will be used during daytime. The greenish tones is here to remind of the golf course, being grass. When opening the app, the first screen to appear is the "new game" screen, and a side menu.
The menu will contain 5 parts:

- The "new game" screen
- The "previous game" screen
- The "rules" screen
- The "calibrate" screen
- The "options" screen
- The "legal mentions" screen

The "new game" screen will feature a single button to press that will start a new game and automatically set up the course which is played on thanks to the user localisation. Then, the part the player is in will be rendered when he will move across the course.
The "previous game" will feature a list of all game played within a certain time frame defined by the user. The user will be able to have more details on each game played by clicking on them. These details include shots for each hole, distance done for each shots, the date and the weather conditions.
The "rules" screen will feature a list of all the current golf rules divided in different sub-menu for a good readability.
The "calibrate" screen is where the user will be able to provide a distance for each golf club. This will allow the app to refine its advice when the user will be on a golf course.
The "options" screen will feature different options such as the time window in which the previous game will be preserved and the colors mode the user want for his app
The "legal mention" will provide all the legal mentions that has to be respected in order for the app to be releasable in the user's country.

## Non functional requirements

The app will be able to track the user's position while consuming a minimal amount of battery. The goal is that the user will be able to use it during a full golf game, which can approach five hours.
The app will be compatible for both Ios and Android devices to extend the possible user base.
The app will have to respect both App store and Play store policies to ensure that it is releasable on both platform.
The app will have to respect Europeans and British law regarding privacy and localisation processing to ensure the app is releasable in Europe and the UK.

## Out of scope

Analysing the swing of the player by using the camera is not planned yet but is a possible improvement for the application.

Having the flag positions in real time is also not planned yet because it can change really often on certain course. However, by accessing a precise enough sattelite view, it would be possible to implement this feature.

Creating balls with sensors on them or putting sensors on other balls is also not planned. The main issues with those solutions are that the ball might not be balanced or not be up to standards anymore. The other issue is that if you do a bad shot and throw your ball in a lake or the woods, it may be impossible to recover them and it would cost a lot.

## Security

The only kind of sensitive data that would be stored is the golf course played. All the localisation processing will be done locally. To protect the player privacy, an asymetric encryption algorithm is planned.

## Glossary

- club: what is used to propel the ball in golf.
