@JS()
library algosigner.js;

import 'package:js/js.dart';

@JS('AlgoSigner.connect')
external String connect();

@JS('AlgoSigner.accounts')
external accounts(AccountsOptions options);

@JS('AlgoSigner.algod')
external algod(AlgodOptions options);

@JS('AlgoSigner.indexer')
external indexer(IndexerOptions options);

@JS('AlgoSigner.signTxn')
external signTransactions(List<dynamic> transactions);

@JS('AlgoSigner.send')
external send(SendOptions options);

@JS()
@anonymous
class AccountsOptions {
  external factory AccountsOptions({
    required String ledger,
  });
  external String get ledger;
}

@JS()
@anonymous
class AlgodOptions {
  external factory AlgodOptions({
    required String ledger,
    required String path,
    String? body,
    String? method,
    String? contentType,
  });
  external String get ledger;
  external String get path;
  external String? get body;
  external String? get method;
  external String? get contentType;
}

@JS()
@anonymous
class IndexerOptions {
  external factory IndexerOptions({
    required String ledger,
    required String path,
  });
  external String get ledger;
  external String get path;
}

@JS()
@anonymous
class SendOptions {
  external factory SendOptions({
    required String ledger,
    required String tx,
  });
  external String get ledger;
  external String get tx;
}
