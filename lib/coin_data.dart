import 'dart:convert';
import 'package:currency_converter/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
//https://apiv2.bitcoinaverage.com/convert/global?from=USD&to=ETH&amount=2
const bitcoinAverageURL =
    'https://apiv2.bitcoinaverage.com/indices/global/ticker';

class CoinData {
  List<String> _toCurrencies = ["BTC", "ETH"];

  Future<List<CurrencyResult>> getCoinData({
    @required double amount,
    @required String selectedCurrency,
  }) async {
    List<CurrencyResult> currencyResults;

    for (String cryptoCurrency in _toCurrencies) {
      String requestURL = '$bitcoinAverageURL/$cryptoCurrency$selectedCurrency';
      //TODO: change.. set amount in api url

      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double value = decodedData['last'];
        String longName = "TEST"; // TODO: get long name
        String shortName = "TEST"; // TODO: get short name
        currencyResults.add(
          CurrencyResult(
              longName: longName, shortName: shortName, value: value),
        );
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }

    return currencyResults;
  }
}
