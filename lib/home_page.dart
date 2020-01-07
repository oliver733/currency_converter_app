import 'package:currency_converter/coin_data.dart';
import 'package:currency_converter/colors.dart';
import 'package:currency_converter/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  FocusNode _amountFocusNode = FocusNode();
  CoinData _coinData;
  TabController _tabController;
  TextEditingController _amountController = TextEditingController(text: "0.00");
  List<CurrencyResult> _currencyResults;

  double _selectedAmount = 0.00;
  String _selectedCurrency = "USD";

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[100],
      nextFocus: false,
      actions: [
        KeyboardAction(
          focusNode: _amountFocusNode,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "DONE",
              style: TextStyle(
                  color: MyColors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    _coinData = CoinData();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  void _addResultCurrency() {}

  void _getResult() async {
    List<CurrencyResult> result = await _coinData.getCoinData(
        amount: _selectedAmount, selectedCurrency: _selectedCurrency);
    setState(() {
      _currencyResults = result;
    });
  }

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
              child: KeyboardActions(
                config: _buildConfig(context),
                child: _fromCurrencyView(),
              ),
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

  Widget _cryptoFiatSwitch() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TabBar(
        labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        labelColor: Colors.black,
        unselectedLabelColor: MyColors.grey,
        unselectedLabelStyle: TextStyle(fontSize: 16),
        indicatorColor: MyColors.blue,
        indicatorSize: TabBarIndicatorSize.label,
        controller: _tabController,
        tabs: <Widget>[
          Tab(
            child: Text(
              "Crypto",
            ),
          ),
          Tab(
            child: Text(
              "Fiat",
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterDropDown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              Text(
                "Alphabetical",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: MyColors.grey,
              )
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            _addResultCurrency();
          },
          icon: Icon(
            Icons.add,
            color: MyColors.grey,
          ),
        )
      ],
    );
  }

  Widget _resultList() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        ListView.builder(
          itemCount: _currencyResults?.length ?? 0,
          itemBuilder: (context, index) {
            return _resultCard(currencyResult: _currencyResults[index]);
          },
        ),
        ListView.builder(
          itemCount: _currencyResults?.length ?? 0,
          itemBuilder: (context, index) {
            return _resultCard(currencyResult: _currencyResults[index]);
          },
        ),
      ],
    );
  }

  Widget _resultCard({@required CurrencyResult currencyResult}) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        color: MyColors.blue,
        child: ListTile(
          title: Text(
            currencyResult.longName,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          trailing: Text(
            '${currencyResult.value} ${currencyResult.shortName}',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _fromCurrencyView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                focusNode: _amountFocusNode,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedAmount = double.tryParse(value);
                  });
                },
                onSubmitted: (_) {
                  _getResult();
                },
                textAlign: TextAlign.end,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                controller: _amountController,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                // dropdown..
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
}
