import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:ispend/providers/transactions.dart';
import 'package:ispend/theme.dart';
import 'package:ispend/ui/building_functionality/building_functionality_screen.dart';
import 'package:ispend/ui/home/components/new_transaction_data_container.dart';
import 'package:ispend/ui/home/home_screen.dart';
import 'package:ispend/ui/new_transaction/new_transaction_screen.dart';
import 'package:ispend/ui/transaction_detail/transaction_detail_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ISpend());
}

class ISpend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Transactions(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ispend',
        theme: theme(),
        home: HomeScreen(),
        routes: {
          TransactionDetailScreen.routeName: (ctx) => TransactionDetailScreen(),
          BuildingFunctionality.routeName: (ctx) => BuildingFunctionality(),
          NewTransactionDataContainer.routeName: (ctx) =>
              NewTransactionDataContainer(),
          NewTransactionForm.routeName: (ctx) => NewTransactionForm(),
        },
      ),
    );
  }
}
