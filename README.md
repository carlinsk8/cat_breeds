# Cat Breeds App
</br>
<img src="assets/screenshots/1.jpg" width="400">
<img src="assets/screenshots/2.jpg" width="400">
<img src="assets/screenshots/3.jpg" width="400">
<img src="assets/screenshots/4.jpg" width="400">
<img src="assets/screenshots/5.jpg" width="400">
<img src="assets/screenshots/6.jpg" width="400">
<img src="assets/screenshots/7.jpg" width="400">
</br>
This project is make in Flutter(Dart language) under the architecture **Clean Architecture**.

>It's architecture based on the book and blog by Uncle Bob. It is a combination of concepts taken from the Onion Architecture and other architectures. The main focus of the architecture is separation of concerns and scalability. It consists of four main modules: core, data, domain, and presentation.
><img src="assets/screenshots/clean_architecture.jpg" width="400">

## Architecture diagram
</br>
<img src="assets/screenshots/clean-architecture-flutter-fiagram.png" width="400">

## Project Organization

### Presentation

This is the stuff you're used to from "unclean" Flutter architecture. You obviously need widgets to display something on the screen. These widgets then dispatch events to the Bloc and listen for states (or an equivalent if you don't use Bloc for state management).

![presentation diagram](assets/screenshots/presentation-layer-diagram.png)

> Note that the "Presentation Logic Holder" (e.g. Bloc or Provider) doesn't do much by itself. It delegates all its work to use cases. At most, the presentation layer handles basic input conversion and validation.

### Domain

Domain is the inner layer which shouldn't be susceptible to the whims of changing data sources or porting our app to Angular Dart. It will contain only the core business logic (use cases) and business objects (entities). It should be totally independent of every other layer.

> Use Cases are classes which encapsulate all the business logic of a particular use case of the app (e.g. LoginUserUseCase or GetCurrentUserUseCase).

But... How is the domain layer completely independent when it gets data from a Repository, which is from the data layer?  Do you see that fancy colorful gradient for the Repository? That signifies that it belongs to both layers at the same time. We can accomplish this with dependency inversion.

![domain diagram](assets/screenshots/domain-layer-diagram.png)

That's just a fancy way of saying that we create an abstract Repository class defining a contract of what the Repository must do - this goes into the domain layer. We then depend on the Repository "contract" defined in domain, knowing that the actual implementation of the Repository in the data layer will fullfill this contract.

> Dependency inversion principle is the last of the SOLID principles. It basically states that the boundaries between layers should be handled with interfaces (abstract classes in Dart).

### Data

The data layer consists of a Repository implementation (the contract comes from the domain layer) and data sources - one is usually for getting remote (API) data and the other for caching that data. Repository is where you decide if you return fresh or cached data, when to cache it and so on.

You may notice that data sources don't return Entities but rather Models. The reason behind this is that transforming raw data (e.g JSON) into Dart objects requires some JSON conversion code. We don't want this JSON-specific code inside the domain Entities - what if we decide to switch to XML?

![data diagram](assets/screenshots/data-layer-diagram.png)

Therefore, we create Model classes which extend Entities and add some specific functionality (toJson, fromJson) or additional fields, like database ID, for example.

The RemoteDataSource will perform HTTP GET requests on the API. LocalDataSource will simply cache data using the shared_preferences package.
</br>


# Getting Started

    - Proyect in Flutter 3.22.2

# Config Env

    - Create file /lib/core/util/env.dart
        - `class Env {
            static String baseApiUrl = 'https://api.thecatapi.com';
            static String token = 'YOUR TOKEN';
        }`

## Run command

    - debug  `flutter run -t lib/main.dart ` 
    
    - release  `flutter run -t lib/main.dart --release `

## Build command
    
    - Android
  
      - apk
        
        - `flutter build apk -t lib/main.dart`