import 'package:flutter/material.dart';
import 'package:ispend/size_config.dart';
import 'components/body.dart';

class NewTransactionForm extends StatelessWidget {
  static const routeName = '/new_transaction_screen';

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Expense'),
        ),
        body: Body());
  }
}
