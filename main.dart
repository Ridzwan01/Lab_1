import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const cryptoExchanfe(),
    );
  }
}

class cryptoExchanfe extends StatefulWidget {
  const cryptoExchanfe({Key? key}) : super(key: key);

  @override
  State<cryptoExchanfe> createState() => _cryptoExchanfe();
}

class _cryptoExchanfe extends State<cryptoExchanfe> {

  String crypto = "eth", fiat = "usd", descriptionCrypto = "", descriptionFiat = "";

  double valuesCrypto = 0;
  double valuesFiat = 0;

  List<String> cryptoList = ["eth","ltc","bch","bnb","eos","xrp","xlm","link","dot","yfi","bits","sats"];

  List<String> fiatList = ["usd","aed","ars","aud","bdt","bhd","bmd","brl","cad","chf","clp","cny","czk",
                           "dkk","eur","gbp","hkd","huf","idr","inr","jpy","krw","kwd","lkr","mmk","mxn",
                           "myr","ngn","nok","nzd","php","pkr","pln","rub","sar","sek","sgd","thb","try",
                           "twd","uah","vef","vnd","zar","xdr"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cryptocurrency Exchange")),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [

            const Text(
              "Bitcoin Exchange", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)
            ),

            const Text(
              " ",
            ),

            const Text(
              "To", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),

            const Text(
              " ",
            ),

            DropdownButton(

                itemHeight: 60,
                value: crypto,
                onChanged: (newValue){
                  setState(() {
                    crypto = newValue.toString();
                  });
                },

                items: cryptoList.map((crypto){
                  return DropdownMenuItem(
                    child: Text(
                      crypto,
                      ),
                      value: crypto,
                    );
                }).toList(),

            ),

            DropdownButton(
              
              itemHeight: 60,
              value: fiat,
              onChanged: (newValue){
                setState(() {
                  fiat = newValue.toString();
                });
              },

              items: fiatList.map((fiat){
                return DropdownMenuItem(
                  child: Text(
                    fiat,
                    ),
                    value: fiat,
                  );
              }).toList(),

            ),

            ElevatedButton(

                onPressed: _loadExchange, child: const Text("Load")
              
            ),
            
            const SizedBox(height: 10),
            
            Text(

              descriptionCrypto,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)

            ),

            Text(

              descriptionFiat,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)

            ),
          ],
        ),
      )
    );
  }

 
  Future<void> _loadExchange() async {
    
    var url = Uri.parse('https://api.coingecko.com/api/v3/exchange_rates');
    var response = await http.get(url);

    if (response.statusCode == 200){
     
      var jsonData = response.body;
      var parseData = json.decode(jsonData);

      valuesCrypto = parseData['rates'][crypto]['value'];
      valuesFiat = parseData['rates'][fiat]['value'];

      setState(() {

        descriptionCrypto = '$crypto values is $valuesCrypto';
        descriptionFiat = '$fiat value is $valuesFiat';

      });
    
    }
  }
}