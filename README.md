# Lenra Client App

The Lenra Client App in Flutter.

This project gives you the possibility to run Lenra apps by only providing a [Phoenix websocket](https://github.com/mfeckie/phoenix_wings) and an application name.

### Requirements
- [flutter](https://flutter.dev/docs/get-started/install)

## Getting Started

### Integration to your project

This library needs a `SocketModel` and an application name to run properly. 

A minimal running example of integration into a project can be represented as :
```dart
ChangeNotifierProvider<SocketModel>(
    create: (context) => AppSocketModel("arbitrary-access-token"),
    child: const App(
        appName: "app-name",
    ),
);
```

As you can see in this example, an arbitrary access token has been defined because the authentication to the websocket has not been handled. 

If your socket requires authentication using a websocket you can follow the `lenra-store` implementation which makes use of an `AuthModel` to handle authentication combined with an `AppSocketModel` that ensures that the access token is set and can be updated anytime within the application lifecycle.

### Running tests

Run flutter test
```sh
flutter test
```

Run flutter test with coverage report (need to install lcov)
```sh
flutter test --coverage && lcov --list coverage/lcov.info
```