# Functional Specification: Caddie

## Introduction

This document serves as a guide for the development, outlining the functional requirements and the different features of the application
The scope of this document encompasses the features, functionalities and user interactions expected in Caddie.

## Table of Contents

- [Functional Specification: Caddie](#functional-specification-caddie)
  - [Introduction](#introduction)
  - [Table of Contents](#table-of-contents)
  - [General Description](#general-description)
    - [Product Perspective](#product-perspective)
    - [Persona](#persona)
  - [Functional Requirements](#functional-requirements)
    - [Feature 1](#feature-1)
  - [User Interface](#user-interface)
    - [Mockups](#mockups)
  - [Non-functional Requirements](#non-functional-requirements)
    - [Security](#security)
    - [Performance](#performance)
    - [Compatibility](#compatibility)
  - [Assumptions](#assumptions)
  - [Appendix](#appendix)
    - [Appendix A: Glossary](#appendix-a-glossary)

## General Description

### Product Perspective

Caddie is a mobile application that helps golf players make better decisions and help them improve their level. The application has 4 main features:

- The "**Next Shot**" feature. This feature advises the player on which type of shot to play next, based on the player's current position, the distance to the hole, the weather conditions and the player's skill.
- The "**Scoreboard**" feature. This feature allows the user to keep track of their score.
- The "**Training**" feature. Thanks to this feature, the user can specify the distance they hit the ball with each club. The application then uses this data to advise the user on which club to use for each shot. In the training part, the user is also advised on which type of shot to improve, and what is wrong with those.
- The "**Rule Book**" feature. This feature allows the user to quickly look up the rules of golf. This feature also allows the application to advise the user on what to do in case of a rule infringement.

The application is designed to be used by golf players of all levels, from beginners to professionals. The application can be used on any golf course and is designed to be used during games or training sessions.
Unlike other applications, Caddie is designed to require less performance, so a user can use it on the golf course without draining their battery. Also, the application does all the calculations on the phone, so the user does not need an internet connection to use the application, reducing battery consumption. This also reduces the risk of sensitive data being stolen, such as current localization.

### Persona

## Functional Requirements

### Feature 1

## User Interface

### Mockups

## Non-functional Requirements

### Security

Since the application does all the calculations on the phone, the localization data is not sent to any server, reducing the risk of sensitive data being stolen.
The only other type of sensitive data is where the user played and when. This data is stored on the phone and is not sent to any server. The user can delete this data at any time or the data will be deleted automatically after 2 years, unless the user wants to save a specific game for later.

### Performance

The application is designed to require less performance, so a user can use it on the golf course without draining their battery. The application does all the calculations on the phone, so the user does not need an internet connection to use the application, reducing battery consumption.

### Compatibility

The application is designed to be used on any Android or iOS phone. It works on version 5.0 and above for Android and version 10 and above for iOS.

## Assumptions

## Appendix

### Appendix A: Glossary
