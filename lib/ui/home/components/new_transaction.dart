import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ispend/models/default_location.dart';
import 'package:ispend/size_config.dart';
import 'package:ispend/ui/home/components/image_input.dart';
import 'package:ispend/ui/home/components/location_input.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  NewTransactionState createState() => NewTransactionState();
}

class NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;
  File _savedPicture;
  DefaultLocation _pickedLocation;

  void _selectImage(File savedPicture) {
    _savedPicture = savedPicture;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = DefaultLocation(latitude: lat, longitude: lng);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: titleController,
              onSubmitted: (_) => submitTransaction(),
              keyboardType: TextInputType.text,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: amountController,
              onSubmitted: (_) => submitTransaction(),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Container(
              height: SizeConfig.availableHeight * 0.05,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen'
                          : 'Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: _presentDatePicker,
                    child: Text('Choose Date'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: ImageInput(_selectImage),
            ),
            SizedBox(
              height: 10,
            ),
            LocationInput(_selectPlace),
            SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                onPressed: submitTransaction,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.button.color),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.green,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void submitTransaction() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addNewTransaction(enteredTitle, enteredAmount, _selectedDate,
        _savedPicture, _pickedLocation);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }
}
