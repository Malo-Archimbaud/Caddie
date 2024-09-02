# Writen Report

## Table of contents

<details>
<summary>Table of contents</summary>

- [Writen Report](#writen-report)
  - [Table of contents](#table-of-contents)
  - [Context](#context)
  - [Target audience](#target-audience)
  - [How Golf works](#how-golf-works)
  - [Requirements](#requirements)
  - [Functionalities](#functionalities)
  - [Technologies](#technologies)
    - [Programming languages](#programming-languages)
    - [Frameworks](#frameworks)
    - [Tools](#tools)
    - [Libraries](#libraries)
  - [Implementation](#implementation)
  - [Choices](#choices)
    - [Technological choices](#technological-choices)
    - [Design choices](#design-choices)
  - [Management](#management)
  - [Future improvements](#future-improvements)
  - [Conclusion](#conclusion)
  
</details>

## Context

As a golf player, it often happened to me or my friends that we found ourselves in a situation where we did not know what to do. We did not know which club to use or where to aim to make the most optimal shot. I also had trouble keeping track of my progress, as I had nowhere to store my scores and analyze them.
This is why I decided to create an application that would help golf players improve their level, adapt to a new course easier, and analyze their results to evaluate their level and give proper advice.

## Target audience

The target audience of this application is golf players who want to improve their level and have a better understanding of the game. The application is designed for players of all levels, from beginners to professionals.

## How Golf works

Golf is a sport that consists of hitting a ball with a club and trying to get it into a hole in the fewest strokes possible. The game is played on a course with a series of holes. Each hole has a tee box, a fairway, a rough, a bunker, and a green with a flagstick and hole. The player starts at the tee box and tries to get the ball into the hole in as few strokes as possible. The player can use different clubs to hit the ball, depending on the distance and the obstacles on the course.

## Requirements

For this project to be considered successful, the following requirements must be met:

- The application must be able to localize the user using GPS.
- The application must be able to advise the user on which club to use
- The application must be able to load the user's data

## Functionalities

The application will have the following functionalities:

- Advice on where to aim and which club to use
- A scorecard to keep track of the user's scores
- A stats page to keep the user's distance
- A rules page to provide all the rules and advice on what to do in each situation

## Technologies

### Programming languages

- Dart

### Frameworks

- Flutter

### Tools

- Android Studio
- Visual Studio Code

### Libraries

- geoloactor: used to get the user's location and calculate the distance to the hole

## Implementation

To determine where to aim and which club to use, each hole or part of a hole is represented by an area defined by 4 points and an aiming point. The first thing done is to check in which area the user is located. Then, the distance to the aiming point is calculated, and the club to use is determined based on the distance and the info the user has provided about his clubs.

To keep track of the user's scores, a scorecard is used. The user can enter his score for each hole and see his total score.

To keep track of the user's distance, a stats page is used. The user can change the distance or add a new club to his bag.

## Choices

### Technological choices

The application was developed using the Flutter framework because it allows for the development of cross-platform applications. This means that the application can be run on both Android and iOS devices. The geolocator library was used to get the user's location and calculate the distance to the hole.

### Design choices

The application was designed to be user-friendly and easy to use. The user interface is simple and intuitive, with clear buttons and labels.

## Management

## Future improvements

## Conclusion
