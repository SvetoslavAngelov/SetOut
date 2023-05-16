# SetOut!
SetOut app for iOS 16.0+

## Overview 
SetOut is an iOS app which allows users to find the most optimal route to visit all tourist attractions in their area. The app is built in Swift
and uses the SwiftUI framework. It's built for iOS 16.0+, the supported iPhone models are iPhone 8+. 

## App structure 

![Untitled Diagram-2](https://user-images.githubusercontent.com/21280671/203430030-6b635b6a-42f4-4849-a6f9-c6d14b783f10.png)

The app features a flash screen, which has no functional purpose, other than to look nice and allow the user to set the location settings, before 
the app transitions to the Root view. 

<img width="720" alt="Screenshot 2022-11-22 at 22 15 42" src="https://user-images.githubusercontent.com/21280671/203432431-64da7e43-95ee-41e9-9640-b86c542b156d.png">

The Root view is composed of a Map background and a sliding card component. The three main sub-views are embedded into the sliding card component and 
use custom navigation, instead of the in-built SwiftUI column navigation pattern.

The Search sub-view is the first one that's embedded into the sliding card component. Users can either use their location as the starting point of the 
route planning process, or they can search and set a custom start location. 

<img width="696" alt="Screenshot 2022-11-22 at 22 23 30" src="https://user-images.githubusercontent.com/21280671/203435043-c0bbe46f-ad09-40ce-9ae5-ba81a555c12a.png">

Once the start location is set users have the option to define the route parameters, including the distance to cover and the time available to view the
tourist attractions. 

After setting all the parameters and the start location, users can then request an itinerary which features the most popular tourist attractions. 
