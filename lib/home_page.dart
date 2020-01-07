import 'package:currency_converter/colors.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Currency Converter',
            style: TextStyle(color: MyColors.grey),
          ),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: _fromCurrency(),
            ),
            Flexible(
              flex: 3,
              child: Column(
                children: <Widget>[
                  _cryptoFiatSwitch(),
                  _filterDropDown(),
                  Expanded(
                    child: _resultList(),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

Widget _cryptoFiatSwitch() {
  return Container();
}

Widget _filterDropDown() {
  return Container();
}

Widget _resultList() {
  return ListView.builder(
    itemCount: 10,
    itemBuilder: (context, index) {
      return Container(
        padding: EdgeInsets.all(5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          color: MyColors.blue,
          child: ListTile(
            title: Text(
              "Bitcoin",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            trailing: Text(
              '0.268307 BTC',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      );
    },
  );
}

Widget _fromCurrency() {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          '2000.00 ',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "\$",
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.w900),
            ),
            Text(
              "USD",
              style: TextStyle(fontSize: 14, color: MyColors.grey),
            )
          ],
        )
      ],
    ),
  );
}

// //

// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'coin_data.dart';
// import 'dart:io' show Platform;

// class PriceScreen extends StatefulWidget {
//   @override
//   _PriceScreenState createState() => _PriceScreenState();
// }

// class _PriceScreenState extends State<PriceScreen> {
//   String selectedCurrency = 'AUD';

//   DropdownButton<String> androidDropdown() {
//     List<DropdownMenuItem<String>> dropdownItems = [];
//     for (String currency in currenciesList) {
//       var newItem = DropdownMenuItem(
//         child: Text(currency),
//         value: currency,
//       );
//       dropdownItems.add(newItem);
//     }

//     return DropdownButton<String>(
//       value: selectedCurrency,
//       items: dropdownItems,
//       onChanged: (value) {
//         setState(() {
//           selectedCurrency = value;
//           getData();
//         });
//       },
//     );
//   }

//   CupertinoPicker iOSPicker() {
//     List<Text> pickerItems = [];
//     for (String currency in currenciesList) {
//       pickerItems.add(Text(currency));
//     }

//     return CupertinoPicker(
//       backgroundColor: Colors.lightBlue,
//       itemExtent: 32.0,
//       onSelectedItemChanged: (selectedIndex) {
//         setState(() {
//           selectedCurrency = currenciesList[selectedIndex];
//           getData();
//         });
//       },
//       children: pickerItems,
//     );
//   }

//   Map<String, double> value = {};

//   void getData() async {
//     try {
//       Map<String, double> map = await CoinData().getCoinData(selectedCurrency);
//       setState(() {
//         value = map;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   List<CryptoCard> getCryptoCards() {
//     List<CryptoCard> cryptoCards = [];
//     for (var crypto in cryptoList) {
//       cryptoCards.add(CryptoCard(
//         bitcoinType: crypto,
//         value: value[crypto],
//         selectedCurrency: selectedCurrency,
//       ));
//     }
//     return cryptoCards;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('🤑 Coin Ticker'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           Column(
//             children: getCryptoCards(),
//           ),
//           Container(
//             height: 150.0,
//             alignment: Alignment.center,
//             padding: EdgeInsets.only(bottom: 30.0),
//             color: Colors.lightBlue,
//             child: Platform.isIOS ? iOSPicker() : androidDropdown(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CryptoCard extends StatelessWidget {
//   const CryptoCard({
//     Key key,
//     @required this.bitcoinType,
//     @required this.value,
//     @required this.selectedCurrency,
//   }) : super(key: key);

//   final String bitcoinType;
//   final double value;
//   final String selectedCurrency;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
//       child: Card(
//         color: Colors.lightBlueAccent,
//         elevation: 5.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
//           child: Text(
//             '1 $bitcoinType = ${value == null ? '?' : value.toString()} $selectedCurrency',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 20.0,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
