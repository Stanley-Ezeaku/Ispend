import 'package:flutter/material.dart';
import 'package:ispend/providers/transactions.dart';
import 'package:ispend/ui/home/components/chart.dart';
import 'package:provider/provider.dart';

class ChartDataContainer extends StatelessWidget {
  const ChartDataContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactionData = Provider.of<Transactions>(context);
    final transaction = transactionData.transactions;
    return Chart(transaction);
  }
}
