import 'package:flutter_algosigner/src/method_channel_algosigner.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The interface that implementations of flutter_algosigner must implement.
///
/// Platform implementations should extend this class rather than implement
/// it as `flutter_algosigner` does not consider newly added methods to be
/// breaking changes.
///
/// Extending this class (using `extends`) ensures that the subclass will get
/// the default implementation, while platform implementations that
/// `implements` this interface will be broken by newly added
/// [AlgoSignerPlatform] methods.
///
/// Normally this should be in a separate package but since we only support web
/// this isn't necessary.
abstract class AlgoSignerPlatform extends PlatformInterface {
  static const _token = Object();
  AlgoSignerPlatform() : super(token: _token);

  static AlgoSignerPlatform _instance = MethodChannelAlgoSigner();

  // ignore: unnecessary_getters_setters
  static AlgoSignerPlatform get instance => _instance;

  // ignore: unnecessary_getters_setters
  static set instance(AlgoSignerPlatform i) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = i;
  }

  /// Requests access to the Wallet for the dApp, may be rejected or approved.
  /// Every access to the extension begins with a connect request, which if
  /// approved by the user, allows the dApp to follow-up with other requests.
  Future<Map<String, dynamic>> connect();

  /// Returns an array of accounts present in the Wallet for the given Network.
  Future<List<dynamic>> accounts({required String ledger});

  /// Proxies the requested path to the Algod v2 API.
  /// Is limited to endpoints made available by the API server.
  /// By default, all calls to the AlgoSigner.algod method are GET.
  Future<Map<String, dynamic>> algod({
    required String ledger,
    required String path,
    String? body,
    String? method,
    String? contentType,
  });

  /// Proxies the requested path to the Indexer v2 API.
  /// Is limited to endpoints made available by the API server.
  /// The API backend may be configured by advanced users and is not
  /// guaranteed to respond as expected.
  Future<Map<String, dynamic>> indexer({
    required String ledger,
    required String path,
  });

  /// Send transaction objects to AlgoSigner for approval.
  /// The Network is determined from the 'genesis-id' property.
  /// If approved, the response is an array of signed transaction objects,
  /// with the binary blob field base64 encoded to prevent transmission issues.
  Future<List<Map<String, dynamic>>> signTransactions({
    required List<Map<String, dynamic>> transactions,
  });

  /// Send a base64 encoded signed transaction blob to AlgoSigner to
  /// transmit to the Network.
  Future<String> send({
    required String ledger,
    required String transaction,
  });
}
