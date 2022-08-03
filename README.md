Original App Design Project - README Template
===

# HangOUT

## Table of Contents
1. Overview
2. Product Spec
3. Wireframes
4. Schema

## Overview
### Description
 Users will be able to connect with othe usersn based on their communication preference and they will also be able to search for map for venues and the location of other users. 

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Social App for entertainment and company
- **Mobile:** Users pick their interest
- **Story:** Allows users to pick a group based on their preferences (Introveted, extroverted, ambivert) through taking a surveys, post suggested outings, connect their to do callender, and swipe thorough           multiple screenc to view the others profile and also the map to find the location(Distance) of mutual friends.
- **Market:** Young people who are looking to looking to enjoy an nice outings with friends and also event planners who are looking to people to pay and attend events.
- **Habit:** Users can use this app whenever they plan on going to an event with someone or in groups.
- **Scope:** It’s a somewhat narrow scope focused on outings and connnections.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can sign up to create a new account using Parse authentication
* User can log in and log out of his or her account
* The current signed in user is persisted across app restarts
* User can pull to refresh the posts submitted to "HangOUT"
* User can tap a post to view post details, including timestamp and caption
* User can message other users on the messanger page
* User can view the list of outings within a certain range
* User can fill a survey in the app
* Users cxan see the distance of others through the map
* ...

**Optional Nice-to-have Stories**

* Users can filter outings by distance
* Users can filter other users by distance

### 2. Screen Archetypes

* [Login Screen]
   * Users will be able to sign up/Create an account
   * Users will be able to login with the account they created
   
* [Profile Screen]
   * Users will be able to choose their profile picture, and write their about and interests
   * 
* [Home Screen]
   *Users can post outings, add a picture is the venue, and be able to see their profile picture
   
* [Map Screen]
   *Users will be able to seen the location of the events closest to them and also the location of other users
   
* [Message Screen]
   * Users will be able to message each other in a group and connect with each other
   
*  [Outing Screen]
   * Users will be able to see outings suggections irrespective of the distance.
   
*  [Goup Screen]
   * Users will be able to create an account for the group of their interest.
   
### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Tab to Home
* Tab to Profile
* Tab to Groups
* Tab to Outings


**Flow Navigation** (Screen to Screen)

* [Login screen]
   * [list screen navigation here]
   * ...
* [list second screen here]
   * [list screen navigation here]
   * ...

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### [BONUS] Digital Wireframes & Mockups
https://www.figma.com/file/CZxnEG289QBY09kEIUwqm7/Untitled?node-id=0%3A1

### [BONUS] Interactive Prototype
https://www.figma.com/file/CZxnEG289QBY09kEIUwqm7/Untitled?node-id=0%3A1
## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
Parse Network Requests Login Screen### Networking
- [Create/POST] Create a new user account when they sign up in HangOUT

Create Post Screen
- [Create/POST] Create a new post object
- [Delete/DELETE] Deleting Comment on the home screen
- [Read/POST] Fetch posts for a user's home

Profile Screen
- [Read/GET] Query logged in user object
- [Update/PUT] Update user profile image in the profile screen


[OPTIONAL: List endpoints if using existing API such as Yelp]
