import 'dart:async';

import 'package:flutter_algosigner/src/algosigner_exception.dart';
import 'package:flutter_algosigner/src/algosigner_platform.dart';
import 'package:flutter_algosigner/src/interop/convert_interop.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js_util.dart';

import 'interop/algosigner_interop.dart' as algosigner;

/// A web implementation of the AlgoSigner plugin.
class AlgoSignerPlugin extends AlgoSignerPlatform {
  static void registerWith(Registrar registrar) {
    AlgoSignerPlatform.instance = AlgoSignerPlugin();
  }

  @override
  Future<Map<String, dynamic>> connect() async {
    var c = Completer<Map<String, dynamic>>();
    promiseToFuture(algosigner.connect())
        .then((value) => c.complete(Map<String, dynamic>.from(convert(value))))
        .onError((error, stackTrace) => c.completeError(_handleError(error)));

    return c.future;
  }

  @override
  Future<List<dynamic>> accounts({required String ledger}) async {
    Completer<List<dynamic>> c = Completer();
    promiseToFuture(
      algosigner.accounts(algosigner.AccountsOptions(ledger: ledger)),
    )
        .then((value) => c.complete(List<dynamic>.from(convertList(value))))
        .onError((error, stackTrace) => c.completeError(_handleError(error)));

    return c.future;
  }

  @override
  Future<Map<String, dynamic>> algod({
    required String ledger,
    required String path,
    String? body,
    String? method,
    String? contentType,
  }) async {
    Completer<Map<String, dynamic>> c = Completer();
    promiseToFuture(
      algosigner.algod(algosigner.AlgodOptions(
        ledger: ledger,
        path: path,
        body: body,
        method: method,
        contentType: contentType,
      )),
    )
        .then((value) => c.complete(Map<String, dynamic>.from(convert(value))))
        .onError((error, stackTrace) => c.completeError(_handleError(error)));

    return c.future;
  }

  @override
  Future<Map<String, dynamic>> indexer({
    required String ledger,
    required String path,
  }) async {
    Completer<Map<String, dynamic>> c = Completer();
    promiseToFuture(
      algosigner.indexer(algosigner.IndexerOptions(
        ledger: ledger,
        path: path,
      )),
    )
        .then((value) => c.complete(Map<String, dynamic>.from(convert(value))))
        .onError((error, stackTrace) => c.completeError(_handleError(error)));

    return c.future;
  }

  @override
  Future<List<Map<String, dynamic>>> signTransactions({
    required List<Map<String, dynamic>> transactions,
  }) async {
    final txs = transactions.map(mapToJSObj).toList();
    Completer<List<Map<String, dynamic>>> c = Completer();
    promiseToFuture(algosigner.signTransactions(txs))
        .then(
          (value) => c.complete(
            List<Map<String, dynamic>>.from(
              convertList(value),
            ),
          ),
        )
        .onError((error, stackTrace) => c.completeError(_handleError(error)));

    return c.future;
  }

  @override
  Future<String> send({
    required String ledger,
    required String transaction,
  }) async {
    Completer<String> c = Completer();
    promiseToFuture(
      algosigner.send(algosigner.SendOptions(
        ledger: ledger,
        tx: transaction,
      )),
    )
        .then(
          (value) => c.complete(convert(value)['txId'] ?? ''),
        )
        .onError((error, stackTrace) => c.completeError(_handleError(error)));

    return c.future;
  }

  AlgoSignerException _handleError(dynamic error) {
    final message = error is String ? error : convert(error)['message'] ?? '';
    return AlgoSignerException(message, error);
  }
}
