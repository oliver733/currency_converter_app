import 'package:flutter/material.dart';

class CurrencyResult {
  final String longName;
  final String shortName;
  final double value;

  CurrencyResult(
      {@required this.longName,
      @required this.shortName,
      @required this.value});
}
