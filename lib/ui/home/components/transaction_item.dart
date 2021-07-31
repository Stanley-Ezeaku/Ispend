import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ispend/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:ispend/ui/new_transaction/new_transaction_screen.dart';
import 'package:ispend/ui/transaction_detail/transaction_detail_screen.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function deletetransaction;
  TransactionItem({Key key, this.transaction, this.deletetransaction})
      : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  // Color bgColors;

  // @override
  // void initState() {
  //   const availableColors = [
  //     Colors.green,
  //     Colors.black,
  //     Colors.pink,
  //     Colors.purple
  //   ];

  //   bgColors = availableColors[Random().nextInt(4)];

  //   super.initState();
  // }

  void _deleteshowDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Delete',
        ),
        content: Text('Are you sure you want to delete item?'),
        actions: [
          TextButton(
            onPressed: () {
              widget.deletetransaction(widget.transaction.id);
              Navigator.of(ctx).pop();
            },
            child: Text('Yes'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('No'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.green,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 4,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: FileImage(widget.transaction.image),
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
                child:
                    Text('\$${widget.transaction.amount.toStringAsFixed(2)}')),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
            '${DateFormat.yMMMd().format(widget.transaction.date)}\n${widget.transaction.location.address}'),
        trailing: Container(
          height: 100,
          width: 100,
          child: Row(children: [
            IconButton(
              icon: Icon(Icons.edit_sharp),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  NewTransactionForm.routeName,
                  arguments: widget.transaction.id,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.cancel_outlined),
              onPressed: _deleteshowDialog,
              color: Theme.of(context).errorColor,
            ),
          ]),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(TransactionDetailScreen.routeName,
              arguments: widget.transaction.id);
        },
      ),
    );
  }
}
