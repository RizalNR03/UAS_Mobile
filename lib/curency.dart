import 'package:flutter/material.dart';

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  String dropdownValue = 'USD';
  double amountToConvert = 0.0;
  Map<String, double> exchangeRates = {
    'USD': 0.000070,
    'EUR': 0.000061,
    'JPY': 0.0077,
    'GBP': 0.000051
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            DropdownButton<String>(
              isExpanded: true,
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['USD', 'EUR', 'JPY', 'GBP']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 16.0),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                amountToConvert = double.tryParse(value) ?? 0.0;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (exchangeRates.containsKey(dropdownValue)) {
                  double convertedAmount =
                      amountToConvert * exchangeRates[dropdownValue]!;
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Conversion Result'),
                        content: Text(
                            '${amountToConvert.toStringAsFixed(2)} IDR = ${convertedAmount.toStringAsFixed(2)} $dropdownValue'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  print('Exchange rate not available for ${dropdownValue}');
                }
              },
              child: Text('Convert'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 15.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
