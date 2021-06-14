import 'dart:async';

import 'package:flutter_algosigner/src/algosigner_platform.dart';

/// Expose the API methods here that should be available for the client.
class AlgoSigner {
  /// Requests access to the Wallet for the dApp, may be rejected or approved.
  /// Every access to the extension begins with a connect request, which if
  /// approved by the user, allows the dApp to follow-up with other requests.
  static Future<Map<String, dynamic>> connect() async {
    final result = await AlgoSignerPlatform.instance.connect();
    return result;
  }

  /// Returns an array of accounts present in the Wallet for the given Network.
  static Future<List<dynamic>> accounts({required String ledger}) async {
    final accounts = await AlgoSignerPlatform.instance.accounts(ledger: ledger);
    return accounts;
  }

  /// Proxies the requested path to the Algod v2 API.
  /// Is limited to endpoints made available by the API server.
  /// By default, all calls to the AlgoSigner.algod method are GET.
  static Future<Map<String, dynamic>> algod({
    required String ledger,
    required String path,
    String? body,
    String? method,
    String? contentType,
  }) async {
    final result = await AlgoSignerPlatform.instance.algod(
      ledger: ledger,
      path: path,
      body: body,
      method: method,
      contentType: contentType,
    );
    return result;
  }

  /// Proxies the requested path to the Indexer v2 API.
  /// Is limited to endpoints made available by the API server.
  /// The API backend may be configured by advanced users and is not
  /// guaranteed to respond as expected.
  static Future<Map<String, dynamic>> indexer({
    required String ledger,
    required String path,
  }) async {
    final result = await AlgoSignerPlatform.instance.indexer(
      ledger: ledger,
      path: path,
    );
    return result;
  }

  /// Send an transaction object to AlgoSigner for approval.
  /// The Network is determined from the 'genesis-id' property.
  /// If approved, the response is an array of signed transaction objects,
  /// with the binary blob field base64 encoded to prevent transmission issues.
  static Future<List<Map<String, dynamic>>> signTransaction(
    Map<String, dynamic> transactions,
  ) async {
    final result = await AlgoSignerPlatform.instance
        .signTransactions(transactions: [transactions]);
    return result;
  }

  /// Send transaction objects to AlgoSigner for approval.
  /// The Network is determined from the 'genesis-id' property.
  /// If approved, the response is an array of signed transaction objects,
  /// with the binary blob field base64 encoded to prevent transmission issues.
  static Future<List<Map<String, dynamic>>> signTransactions(
    List<Map<String, dynamic>> transactions,
  ) async {
    final result = await AlgoSignerPlatform.instance
        .signTransactions(transactions: transactions);
    return result;
  }

  /// Send a base64 encoded signed transaction blob to AlgoSigner to
  /// transmit to the Network.
  ///
  /// Returns the id of the transactions.
  static Future<String> send({
    required String ledger,
    required String transaction,
  }) async {
    final txId = await AlgoSignerPlatform.instance.send(
      ledger: ledger,
      transaction: transaction,
    );

    return txId;
  }
}
