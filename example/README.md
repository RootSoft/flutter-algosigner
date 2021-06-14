<p align="center"> 
<img src="https://github.com/PureStake/algosigner/raw/develop/media/algosigner-wallet-banner-3.png">
</p>

# AlgoSigner
[![pub.dev][pub-dev-shield]][pub-dev-url]
[![Effective Dart][effective-dart-shield]][effective-dart-url]
[![Stars][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

AlgoSigner is a blockchain wallet that makes it easy to use Algorand-based applications on the web. Simply create or import your Algorand account, visit a compatible dApp, and approve or deny transactions — all from within your browser.

AlgoSigner opens the door for developers to build DeFi applications on [Algorand](https://www.algorand.com/) by providing a secure way to add transaction capabilities. This enables developers to initiate transactions and accept ALGOs seamlessly, without jeopardizing the security of their users’ secrets.

DApp users can trust AlgoSigner to:

* Securely store and encrypt account secrets
* Authorize transactions without giving dApps direct access to their keys
* Sign and approve transactions when using dApps

The **flutter-algosigner** web plugin wraps the JavaScript API and exposes methods for Flutter developers. This way, Flutter web developers can benefit and create web3 dApplications. The plugin was developed by RootSoft and is not affiliated with PureStake or AlgoSigner is any way. For more information, check out the official AlgoSigner [documentation](https://github.com/PureStake/algosigner/blob/develop/docs/dApp-guide.md).

## Introduction

AlgoSigner injects a JavaScript library into every web page the browser user visits, which allows the site to interact with the extension. The dApp can use the injected library to connect to the user's Wallet, discover account addresses it holds, query the Network (make calls to AlgoD v2 or the Indexer) and request AlgoSigner to request for the user to sign a transaction initiated by the application. All methods of the injected library return a Future that needs to be handled by the dApp.

The flutter-algosigner plugin follows the AlgoSigner API closely and all methods are available. The plugin integrates elegantly with the [algorand_dart](https://github.com/RootSoft/algorand-dart) SDK so transactions can be easily signed and approved.

Once installed, you can simply sign transactions and start sending payments:

```dart
algorand.sendPayment(
    account: account,
    recipient: newAccount.address,
    amount: Algo.toMicroAlgos(5),
);
```

## Getting started

### Installation

You can install the package via pub.dev:

```bash
flutter pub add flutter_algosigner
```

This will add a line like this to your package's pubspec.yaml (and run an implicit dart pub get):

```yaml
dependencies:
  flutter_algosigner: ^latest-version
```

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

## Usage
Create an ```AlgodClient``` and ```IndexerClient``` and pass them to the ```Algorand``` constructor.
We added extra support for locally hosted nodes & third party services (like PureStake).

```dart
await AlgoSigner.connect();
final txs = await AlgoSigner.signTransaction(
    {
      'txn': transaction.toBase64(),
    },
);
```

## Methods
Accounts are entities on the Algorand blockchain associated with specific onchain data, like a balance. An Algorand Address is the identifier for an Algorand account.

### connect()

Requests access to the Wallet for the dApp, may be rejected or approved. Every access to the extension begins with a connect request, which if approved by the user, allows the dApp to follow-up with other requests.

```dart
await AlgoSigner.connect();
```

## Changelog

Please see [CHANGELOG](CHANGELOG.md) for more information on what has changed recently.

## Contributing & Pull Requests
Feel free to send pull requests.

Please see [CONTRIBUTING](.github/CONTRIBUTING.md) for details.

## Credits

- [Tomas Verhelst](https://github.com/rootsoft)
- [All Contributors](../../contributors)

## License

The MIT License (MIT). Please see [License File](LICENSE.md) for more information.


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[pub-dev-shield]: https://img.shields.io/pub/v/flutter_algosigner?style=for-the-badge
[pub-dev-url]: https://pub.dev/packages/flutter_algosigner
[effective-dart-shield]: https://img.shields.io/badge/style-effective_dart-40c4ff.svg?style=for-the-badge
[effective-dart-url]: https://github.com/tenhobi/effective_dart
[stars-shield]: https://img.shields.io/github/stars/rootsoft/flutter-algosigner.svg?style=for-the-badge&logo=github&colorB=deeppink&label=stars
[stars-url]: https://github.com/RootSoft/flutter-algosigner/stargazers
[issues-shield]: https://img.shields.io/github/issues/rootsoft/flutter-algosigner.svg?style=for-the-badge
[issues-url]: https://github.com/rootsoft/flutter-algosigner/issues
[license-shield]: https://img.shields.io/github/license/rootsoft/flutter-algosigner.svg?style=for-the-badge
[license-url]: https://github.com/RootSoft/flutter-algosigner/blob/master/LICENSE