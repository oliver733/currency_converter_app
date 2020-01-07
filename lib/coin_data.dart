import 'dart:convert';
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

const bitcoinAverageURL =
    'https://apiv2.bitcoinaverage.com/indices/global/ticker';

class CoinData {
  Future<Map> getCoinData(String selectedCurrency) async {
    Map<String, double> map = {};
    for (String cryptoCurrency in cryptoList) {
      String requestURL = '$bitcoinAverageURL/$cryptoCurrency$selectedCurrency';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['last'];
        map.addAll({cryptoCurrency: lastPrice});
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return map;
  }
}

//ex https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCSGD
