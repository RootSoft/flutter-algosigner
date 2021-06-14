import 'package:flutter/services.dart';
import 'package:flutter_algosigner/src/algosigner_platform.dart';

const MethodChannel _channel = MethodChannel('algosigner');

class MethodChannelAlgoSigner extends AlgoSignerPlatform {
  @override
  Future<Map<String, dynamic>> connect() async {
    final result = await _channel.invokeMethod<Map<String, dynamic>>(
      'connect',
    );

    return result ?? <String, dynamic>{};
  }

  @override
  Future<List<dynamic>> accounts({required String ledger}) async {
    final accounts = await _channel.invokeMethod<List<dynamic>?>(
      'accounts',
      <String, Object>{
        'ledger': ledger,
      },
    );

    return accounts ?? [];
  }

  @override
  Future<Map<String, dynamic>> algod({
    required String ledger,
    required String path,
    String? body,
    String? method,
    String? contentType,
  }) async {
    final response = await _channel.invokeMethod<Map<String, dynamic>?>(
      'algod',
      <String, Object?>{
        'ledger': ledger,
        'path': path,
        'body': body,
        'method': method,
        'contentType': contentType,
      },
    );

    return response ?? {};
  }

  @override
  Future<Map<String, dynamic>> indexer({
    required String ledger,
    required String path,
  }) async {
    final response = await _channel.invokeMethod<Map<String, dynamic>?>(
      'indexer',
      <String, Object?>{
        'ledger': ledger,
        'path': path,
      },
    );

    return response ?? {};
  }

  @override
  Future<List<Map<String, dynamic>>> signTransactions({
    required List<Map<String, dynamic>> transactions,
  }) async {
    final signedTxs = await _channel.invokeMethod<List<Map<String, dynamic>>?>(
      'signTransactions',
      transactions,
    );

    return signedTxs ?? [];
  }

  @override
  Future<String> send({
    required String ledger,
    required String transaction,
  }) async {
    final txId = await _channel.invokeMethod<String?>(
      'send',
      <String, Object?>{
        'ledger': ledger,
        'transaction': transaction,
      },
    );

    return txId ?? '';
  }
}
