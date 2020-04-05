import 'package:flutter/material.dart';
// import 'price_screen.dart';
import 'dart:convert';

// import 'package:flutter/material.dart';
import 'coin_data.dart';
// import 'REST API/fetch_exchange_rate.dart';
import 'package:http/http.dart' as http;

void main() {
//  List<String,dynamic> =await moneyToCrypto();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.white),
      home: PriceScreen(),
    );
  }
}

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'INR';
  String price;
  List<DropdownMenuItem> getDropdownItems() {
    List<DropdownMenuItem<String>> dropdownitems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
        child: Text('$currency'),
        value: currency,
      );
      dropdownitems.add(newItem);
    }
    return dropdownitems;
  }

  @override
  void initState() {
    super.initState();
    getDropdownItems();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    price = await moneyToCrypto();
  }

  Future<String> moneyToCrypto() async {
    try {
      String url =
          'https://api.nomics.com/v1/currencies/ticker?key=demo-26240835858194712a4f8cc0dc635c7a&ids=BTC,ETH,XRP&interval=1d,30d&convert=EUR#';

      http.Response response = await http.get(url);
      // print(response);
      print(json.decode(response.body)[0]['price']);
      state = true;
      return (json.decode(response.body)[0]['price'] as String);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  bool state = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: <Widget>[
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      state ? '$price' : '',
                      // price,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = ? USD',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = ? USD',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
                value: selectedCurrency,
                items: getDropdownItems(),
                onChanged: (value) {
                  print(value);
                  setState(() {
                    selectedCurrency = value;
                  });
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        // setState(()  {
        //   cvalue =  moneyToCrypto();
        //   state = true;
        //   print(cvalue);
        // });
      }),
    );
  }
}
