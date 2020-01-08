import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrencyName {
  final String longName;
  final String shortName;

  CurrencyName({
    @required this.longName,
    @required this.shortName,
  });
}

class CurrencyResult {
  final CurrencyName currencyName;
  final double amount;

  CurrencyResult({@required this.currencyName, @required this.amount});
}

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

List<CurrencyName> allCryptoList = [
  CurrencyName(shortName: "BTC", longName: "Bitcoin"),
  CurrencyName(shortName: "ETH", longName: "Etherium"),
  CurrencyName(shortName: "LTC", longName: "Litecoin")
];

class CoinData {
  List<CurrencyName> selectedCurrencies = [
    CurrencyName(shortName: "BTC", longName: "Bitcoin"),
    CurrencyName(shortName: "ETH", longName: "Etherium"),
  ];

  Future<List<CurrencyResult>> getCoinData({
    @required double amount,
    @required String fromCurrency,
  }) async {
    List<CurrencyResult> result = List<CurrencyResult>();
    for (CurrencyName cryptoCurrency in selectedCurrencies) {
      String requestURL =
          'https://apiv2.bitcoinaverage.com/convert/global?from=$fromCurrency&to=${cryptoCurrency.shortName}&amount=$amount';

      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        if (decodedData['success'] == true) {
          double price = decodedData['price'];
          result
              .add(CurrencyResult(currencyName: cryptoCurrency, amount: price));
        }
      } else {
        print(response.statusCode);
      }
    }

    return result;
  }
}
