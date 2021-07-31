import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:ispend/models/default_location.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  File image;
  DefaultLocation location;

  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date,
      @required this.image,
      @required this.location});
}
