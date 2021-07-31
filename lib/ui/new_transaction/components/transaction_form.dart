import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ispend/models/default_location.dart';
import 'package:ispend/models/transaction.dart';
import 'package:ispend/providers/transactions.dart';
import 'package:ispend/size_config.dart';
import 'package:ispend/ui/home/components/image_input.dart';
import 'package:ispend/ui/home/components/location_input.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function addNewTransaction;
  final Function updateTransaction;
  TransactionForm(this.addNewTransaction, this.updateTransaction);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  DateTime _selectedDate;
  File _savedPicture;
  DefaultLocation _pickedLocation;

  void _selectImage(File savedPicture) {
    _savedPicture = savedPicture;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = DefaultLocation(latitude: lat, longitude: lng);
  }

  final _amountFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedTransaction = Transaction(
    id: null,
    title: '',
    amount: 0,
    date: null,
    image: null,
    location: null,
  );

  var _isInit = true;
  var _initValues = {
    'title': '',
    'amount': '',
    'date': '',
    'image': '',
    'latitude': '',
    'longitude': '',
  };

  @override
  void dispose() {
    _amountFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final transactionId = ModalRoute.of(context).settings.arguments as String;
      if (transactionId != null) {
        _editedTransaction = Provider.of<Transactions>(context, listen: false)
            .findById(transactionId);
        _initValues = {
          'title': _editedTransaction.title,
          'amount': _editedTransaction.amount.toString(),
          'date': _editedTransaction.date.toString(),
          'image': _editedTransaction.image.path,
          'latitude': _editedTransaction.location.latitude.toString(),
          'longitude': _editedTransaction.location.latitude.toString()
        };
      }
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Complete your form',
        ),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Ok'))
        ],
      ),
    );
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
      // const errorMessage = 'Fill up the Field';
      // return _showErrorDialog(errorMessage);
    } else if (_selectedDate == null) {
      const errorMessage = 'Pick a date';
      return _showErrorDialog(errorMessage);
    } else if (_savedPicture == null) {
      const errorMessage = 'Take a picture';
      return _showErrorDialog(errorMessage);
    } else if (_pickedLocation == null) {
      const errorMessage = 'Pick a location';
      return _showErrorDialog(errorMessage);
    }

    _form.currentState.save();

    if (_editedTransaction.id != null) {
      widget.updateTransaction(
          _editedTransaction.id,
          _editedTransaction.title,
          _editedTransaction.amount,
          _selectedDate,
          _savedPicture,
          _pickedLocation);
    } else {
      widget.addNewTransaction(
          _editedTransaction.title,
          _editedTransaction.amount,
          _selectedDate,
          _savedPicture,
          _pickedLocation);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            initialValue: _initValues['title'],
            decoration:
                InputDecoration(labelText: 'Item', hintText: 'type here...'),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_amountFocusNode);
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please provide a value.';
              }
              return null;
            },
            onSaved: (value) {
              _editedTransaction = Transaction(
                id: _editedTransaction.id,
                title: value,
                amount: _editedTransaction.amount,
                date: _editedTransaction.date,
                image: _editedTransaction.image,
                location: _editedTransaction.location,
              );
            },
          ),
          SizedBox(
            height: 26,
          ),
          TextFormField(
            initialValue: _initValues['amount'],
            decoration: InputDecoration(
              labelText: 'Amount',
              hintText: '0.0',
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            focusNode: _amountFocusNode,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter an amount.';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }

              if (double.parse(value) <= 0) {
                return 'Please enter a number greater than zero';
              }

              return null;
            },
            onSaved: (value) {
              _editedTransaction = Transaction(
                id: _editedTransaction.id,
                title: _editedTransaction.title,
                amount: double.parse(value),
                date: _editedTransaction.date,
                image: _editedTransaction.image,
                location: _editedTransaction.location,
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: SizeConfig.availableHeight * 0.05,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Chosen'
                        : '${DateFormat.yMMMd().format(_selectedDate)}',
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
              onPressed: _saveForm,
              child: Text(
                'Add Expense',
                style:
                    TextStyle(color: Theme.of(context).textTheme.button.color),
              ),
              style: TextButton.styleFrom(
                primary: Colors.green,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
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
