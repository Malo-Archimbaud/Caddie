# Technical specification

## Introduction

This document describes the technical specification of the project. It includes the architecture, and implementation details of the project.

## General view

Caddie is an application that allows golf players to make the best decision for every shot they have to make.

It will help players thanks to an algorithm that guides them on where to aim and how far they should try to go.

The app will collect the localization of the user to adjust its advice in the function of the course.

It will also collect data on the user such as the distance he can send the ball to and his scores to adapt to the user level.

The app will also provide all the rules and advice on what to do in each situation.

## Objectives

- Help a golf player improve his level
- Adapt a new course easier
- Analyse his results to evaluate his level and give proper advice

## Technologies

- Flutter

## Implementation

The application will be developed using the Flutter framework. The application will be available on Android platforms.

The application will use the GPS of the phone to localize the user and give him advice on where to aim and how far he should try to go.

To know which hole the user is on, the golf course is divided into zones, delimited by 4 sides. Each zone will have a GPS coordinate that is corresponding to where to aim when in the said zone. Then, depending on the distance the user can send the ball with a club, the most optimal club will be chosen. The user will be able to input his score to evaluate his level and give him advice on what to do.

The application will also provide all the rules and advice on what to do in each situation.

To store the data like course and user data, JSON files will be used. Those files will be stored on the phone.
There are 3 types of JSON files:

- Localization of the courses

example:

```json
{
    "golf_courses": [
        {
            "name": "Bourges",
            "coordinates": {
                "latitude": 47.0527,
                "longitude": 2.4129
            }
        },
        {
            "name": "Vierzon",
            "coordinates": {
                "latitude": 47.2396,
                "longitude": 2.1285
            }
        }
    ]
}
```

- Localization of the zones

example:

```json
{
    "Holes": [
        {
            "area": [
                [47.053183, 2.413813],
                [47.052786, 2.413362],
                [47.051097, 2.417122],
                [47.051446, 2.417350]
            ],
            "name": 1,
            "aim": [47.051353, 2.416996]
        }
    ]
}
```

- User data

example:

```json
{
    "name": "Malo",
    "clubs": ["driver", "hybride5", "fer5", "fer6", "fer7", "fer8", "fer9", "pw", "sw", "putter"],
    "maxDistances": [200, 180, 150, 140, 130, 120, 110, 90, 60, 0]
}
```

The first file is used to load the corresponding zones file of the course the user is on. The second file is used to know where to aim in each zone. The third file is used to calculate the most optimal club to use.
