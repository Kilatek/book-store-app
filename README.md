# Book Store TDD Clean Architecture

Flutter project using TDD Clean Architecture and bloc pattern

## Getting Started

## Table of Contents

- [Book Store TDD Clean Architecture](#book-store-tdd-clean-architecture)
  - [Getting Started](#getting-started)
  - [Table of Contents](#table-of-contents)
    - [Features](#features)
    - [Requirements](#requirements)
    - [Project Structure](#project-structure)
    - [Libraries Used](#libraries-used)
    - [Installation](#installation)
    - [Usage](#usage)
    - [Tests](#tests)
    - [Contributing](#contributing)
    - [License](#license)

### Features

### Requirements

- Dart: 3.1.1
- Flutter SDK: 3.13.3
- CocoaPods: 1.12.1

### Project Structure

<img src="./architecture-proposal.png" style="display: block; margin-left: auto; margin-right: auto; width: 75%;"/>

### Libraries Used

1. `bloc`: Used for state management.
2. `dartz`: Provides functional programming tools.
3. `flutter_bloc`: Extends BLoC pattern for Flutter.
4. `get_it`: A service locator for dependency injection.
5. `http`: Allows making HTTP requests.
6. `shared_preferences`: For local data storage.
7. `flutter_svg`: Handles SVG files.
8. `font_awesome_flutter`: Provides Font Awesome icons.
9. `firebase_core`: Required for Firebase integration.
10. `flutter_secure_storage`: For secure storage.
11. `freezed_annotation`: Used for code generation.
12. `freezed`: Supports code generation with Freezed.
13. `build_runner`: Used for code generation.
14. `json_annotation`: For JSON serialization.
15. `json_serializable`: Generates JSON serialization code.
16. `retrofit`: Used for making REST API calls.
17. `retrofit_generator`: Generates Retrofit code.
18. `injectable`: A dependency injection framework.
19. `auto_route`: Handles navigation routing.
20. `firebase_database`: Firebase Realtime Database.
21. `auto_route_generator`: Generates AutoRoute code.
22. `mockito`: For mocking objects in tests.
23. `flutter_lints`: Provides linting rules for Flutter.

### Installation

1 Getting Started:

Make sure you have Flutter and Dart installed on your machine. You can install them by following the instructions in the [official Flutter documentation](https://flutter.dev/docs/get-started/install).

2 Clone this repository:

```bash
git clone https://github.com/TechKala/book-store-app.git
```

3 Navigate to the project directory:

```bash
cd book-store-app
```

4 Install dependencies:

```bash
flutter pub get
```

5 Firebase config:

- Create project in here <https://console.firebase.google.com/>
- Add Firebase to flutter app <https://firebase.google.com/docs/flutter/setup>
- Enable Database Realtime.
- Download files from [Google Driver](https://drive.google.com/drive/folders/1weVqSGtMlAySuwY3LpYwLNcCoz0wkI5F):
  - firebase_options.dart >> lib/
  - google-services.json >> android/app/
  - keystore.properties >> android/app/
  - GoogleService-Info.plist >> ios/Runner/
  - firebase_app_id_file.json >> ios/

6 Generate files:

- cd to root folder of project
- Run `dart run build_runner build --delete-conflicting-outputs`
- Run & Enjoy!

## Usage

Run the app on a simulator or device:

```bash
flutter run
```

The app should start and you can explore the books.

### Tests

```bash
flutter test
```

### Contributing

Contributions are welcome! If you find any bugs or want to add new features, feel free to open an issue or submit a pull request. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as needed.

### License

This project is licensed under the [MIT License](LICENSE).
