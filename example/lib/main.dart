import 'package:algorand_dart/algorand_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_algosigner/algosigner.dart';
import 'package:flutter_algosigner/algosigner_web.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

final algorand = Algorand(
  algodClient: AlgodClient(apiUrl: AlgoExplorer.TESTNET_ALGOD_API_URL),
  indexerClient: IndexerClient(apiUrl: AlgoExplorer.TESTNET_INDEXER_API_URL),
);

class _MyAppState extends State<MyApp> {
  final String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            try {
              final address = Address.fromAlgorandAddress(
                address:
                    // ignore: lines_longer_than_80_chars
                    'KTFZ5SQU3AQ6UFYI2QOWF5X5XJTAFRHACWHXAZV6CPLNKS2KSGQWPT4ACE',
              );

              // Fetch the suggested transaction params
              final params = await algorand.getSuggestedTransactionParams();

              // Build the transaction
              final transaction = await (PaymentTransactionBuilder()
                    ..sender = address
                    ..note = 'Hi from Flutter'
                    ..amount = Algo.toMicroAlgos(0.1)
                    ..receiver = address
                    ..suggestedParams = params)
                  .build();

              await AlgoSigner.connect();
              final txs = await AlgoSigner.signTransactions(
                [
                  {
                    'txn': transaction.toBase64(),
                  },
                ],
              );

              final blob = txs[0]['blob'];
              print(blob);

              print('Sending tx');

              // Send the transaction
              final txId = await AlgoSigner.send(
                ledger: 'TestNet',
                transaction: blob,
              );

              final tx = await algorand.waitForConfirmation(txId);
              print('Confirmed tx id in round: ${tx.confirmedRound}');
            } on AlgoSignerException catch (ex) {
              print('unable to connect ${ex.message}');
            } on AlgorandException catch (ex) {
              print('unable to send transaction ${ex.message}');
            } catch (ex) {
              print('unable to send transaction $ex');
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
