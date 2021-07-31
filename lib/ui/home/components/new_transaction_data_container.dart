import 'package:flutter/material.dart';
import 'package:ispend/providers/transactions.dart';
import 'package:ispend/ui/home/components/new_transaction.dart';
import 'package:provider/provider.dart';

class NewTransactionDataContainer extends StatelessWidget {
  static const routeName = '/new_transaction';
  @override
  Widget build(BuildContext context) {
    final transactionData = Provider.of<Transactions>(context);
    final addNewTransaction = transactionData.addNewTransaction;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: NewTransaction(addNewTransaction),
    ));
  }
}
