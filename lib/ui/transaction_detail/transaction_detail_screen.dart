import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ispend/providers/transactions.dart';
import 'package:ispend/ui/map/map_screen.dart';
import 'package:provider/provider.dart';

class TransactionDetailScreen extends StatelessWidget {
  static const routeName = '/transaction_detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedTransaction =
        Provider.of<Transactions>(context, listen: false).findById(id);
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(selectedTransaction.title),
    //     backgroundColor: Colors.transparent,
    //   ),
    //   body: Column(
    //     children: [
    //       Container(
    //         height: 250,
    //         width: double.infinity,
    //         child: Image.file(
    //           selectedTransaction.image,
    //           fit: BoxFit.cover,
    //           width: double.infinity,
    //         ),
    //       ),
    //       SizedBox(
    //         height: 10,
    //       ),
    //       Text(
    //         selectedTransaction.location.address,
    //         textAlign: TextAlign.center,
    //         style: TextStyle(
    //           fontSize: 20,
    //           color: Colors.grey,
    //         ),
    //       ),
    //       SizedBox(
    //         height: 10,
    //       ),
    //       TextButton(
    //         onPressed: () {
    //           Navigator.of(context).push(
    //             MaterialPageRoute(
    //               fullscreenDialog: true,
    //               builder: (ctx) => MapScreen(
    //                 initialLocation: selectedTransaction.location,
    //                 isSelecting: false,
    //               ),
    //             ),
    //           );
    //         },
    //         child: Text('View on Map'),
    //       )
    //     ],
    //   ),
    // );

    return Scaffold(
        appBar: AppBar(
          title: Text(selectedTransaction.title),
        ),
        body: ListView(children: <Widget>[
          Image.file(
            selectedTransaction.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Container(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          selectedTransaction.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "Date: " +
                            DateFormat.yMMMMd()
                                .format(selectedTransaction.date),
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                      Text(
                        "Amount: " + selectedTransaction.amount.toString(),
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.location_history,
                  color: Colors.red[500],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (ctx) => MapScreen(
                          initialLocation: selectedTransaction.location,
                          isSelecting: false,
                        ),
                      ),
                    );
                  },
                  child: Text('View on Map'),
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                'Description:',
                softWrap: true,
              ))
        ]));
  }
}
