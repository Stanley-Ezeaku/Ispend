import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ispend/helpers/db_helper.dart';
import 'package:ispend/helpers/location_helper.dart';
import 'package:ispend/models/default_location.dart';
import 'package:ispend/models/transaction.dart';

class Transactions with ChangeNotifier {
  List<Transaction> _transactions = [];

  List<Transaction> get transactions {
    return [..._transactions];
  }

  Transaction findById(String id) {
    return _transactions.firstWhere((element) => element.id == id);
  }

  Future<void> addNewTransaction(
    String textTitle,
    double textAmount,
    DateTime selectedDate,
    File imagePicked,
    DefaultLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = DefaultLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: textTitle,
      amount: textAmount,
      date: selectedDate,
      image: imagePicked,
      location: updatedLocation,
    );
    _transactions.add(newTransaction);
    notifyListeners();
    DBHelper.insert(
      'user_transactions',
      {
        'id': newTransaction.id,
        'title': newTransaction.title,
        'amount': newTransaction.amount.toString(),
        'date': newTransaction.date.toString(),
        'image': newTransaction.image.path,
        'loc_lat': newTransaction.location.latitude,
        'loc_lng': newTransaction.location.longitude,
        'address': newTransaction.location.address,
      },
    );
  }

  Future<void> updateTransaction(
    String id,
    String textTitle,
    double textAmount,
    DateTime selectedDate,
    File imagePicked,
    DefaultLocation pickedLocation,
  ) async {
    final prodIndex = _transactions.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final address = await LocationHelper.getPlaceAddress(
          pickedLocation.latitude, pickedLocation.longitude);
      final updatedLocation = DefaultLocation(
          latitude: pickedLocation.latitude,
          longitude: pickedLocation.longitude,
          address: address);
      final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: textTitle,
        amount: textAmount,
        date: selectedDate,
        image: imagePicked,
        location: updatedLocation,
      );
      _transactions.insert(prodIndex, newTransaction);
      notifyListeners();
      DBHelper.insert(
        'user_transactions',
        {
          'id': newTransaction.id,
          'title': newTransaction.title,
          'amount': newTransaction.amount.toString(),
          'date': newTransaction.date.toString(),
          'image': newTransaction.image.path,
          'loc_lat': newTransaction.location.latitude,
          'loc_lng': newTransaction.location.longitude,
          'address': newTransaction.location.address,
        },
      );
    } else {}
  }

  void deleteTransaction(String id) {
    _transactions.removeWhere((element) => element.id == id);
    notifyListeners();
    DBHelper.delete('user_transactions', id);
  }

  Future<void> fetchAndsetTransactions() async {
    final datalist = await DBHelper.getData('user_transactions');
    _transactions = datalist
        .map((element) => Transaction(
              id: element['id'],
              title: element['title'],
              amount: double.parse(element['amount']),
              date: DateTime.parse(element['date']),
              image: File(element['image']),
              location: DefaultLocation(
                  latitude: element['loc_lat'],
                  longitude: element['loc_lng'],
                  address: element['address']),
            ))
        .toList();
    notifyListeners();
  }
}
