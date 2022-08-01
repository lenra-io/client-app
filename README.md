<div id="top"></div>
<!--
*** This README was created with https://github.com/othneildrew/Best-README-Template
-->



<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![LGPL License][license-shield]][license-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">

<h3 align="center">Lenra Client App</h3>

  <p align="center">
    The Lenra Client App in Flutter.
    <br />
    <br />
    <a href="https://github.com/lenra-io/client-app/issues">Report Bug</a>
    ·
    <a href="https://github.com/lenra-io/client-app/issues">Request Feature</a>
  </p>
</div>

<div style="text-align: justify">
This project gives you the possibility to run Lenra apps by only providing a <a href="https://github.com/mfeckie/phoenix_wings">Phoenix websocket</a> and an application name.
</div>

<!-- GETTING STARTED -->

## Prerequisites

- [flutter](https://flutter.dev/docs/get-started/install)

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- USAGE EXAMPLES -->
## Usage

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

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please open an issue with the tag "enhancement".
Don't forget to give the project a star if you liked it! Thanks again!

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the **LGPL** License. See [LICENSE](./LICENSE) for more information.

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Lenra - [@lenra_dev](https://twitter.com/lenra_dev) - contact@lenra.io

Project Link: [https://github.com/lenra-io/client-app](https://github.com/lenra-io/client-app)

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/lenra-io/client-app.svg?style=for-the-badge
[contributors-url]: https://github.com/lenra-io/client-app/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/lenra-io/client-app.svg?style=for-the-badge
[forks-url]: https://github.com/lenra-io/client-app/network/members
[stars-shield]: https://img.shields.io/github/stars/lenra-io/client-app.svg?style=for-the-badge
[stars-url]: https://github.com/lenra-io/client-app/stargazers
[issues-shield]: https://img.shields.io/github/issues/lenra-io/client-app.svg?style=for-the-badge
[issues-url]: https://github.com/lenra-io/client-app/issues
[license-shield]: https://img.shields.io/github/license/lenra-io/client-app.svg?style=for-the-badge
[license-url]: https://github.com/lenra-io/client-app/blob/master/LICENSE


