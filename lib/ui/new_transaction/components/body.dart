import 'package:flutter/material.dart';
import 'package:ispend/providers/transactions.dart';
import 'package:ispend/ui/new_transaction/components/transaction_form.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionData = Provider.of<Transactions>(context);
    final addNewTransaction = transactionData.addNewTransaction;
    final updateTransaction = transactionData.updateTransaction;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.availableWidth * 0.06),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.availableHeight * 0.04),
                Text(
                  "Expense Form",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.availableWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Keeping track of your expenses is an important part of managing your overall finances. While you don’t need to worry, ispend will help you keep record of your purchases, it can certainly come in handy while shopping.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: SizeConfig.availableWidth * 0.04),
                ),
                SizedBox(
                  height: 20,
                ),
                TransactionForm(addNewTransaction, updateTransaction),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
