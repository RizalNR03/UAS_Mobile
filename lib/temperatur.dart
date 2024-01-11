import 'package:flutter/material.dart';

class TempApp extends StatefulWidget {
  @override
  TempState createState() => TempState();
}

class TempState extends State<TempApp> {
  TextEditingController _controller = TextEditingController();
  late double input;
  late double output;
  late bool fOrC;

  @override
  void initState() {
    super.initState();
    input = 0.0;
    output = 0.0;
    fOrC = true;
  }

  @override
  Widget build(BuildContext context) {
    TextField inputField = TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      onChanged: (str) {
        try {
          input = double.parse(_controller.text);
        } catch (e) {
          input = 0.0;
        }
      },
      decoration: InputDecoration(
        labelText: "Masukan Suhu di ${fOrC ? "Celsius" : "Fahrenheit"}",
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      textAlign: TextAlign.center,
    );

    AppBar appBar = AppBar(
      title: Text(
        "Temperature Calculator",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: Colors.blue,
    );

    Container tempSwitch = Container(
      padding: EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Fahrenheit",
            style: TextStyle(fontSize: 16),
          ),
          Radio<bool?>(
            groupValue: fOrC,
            value: false,
            onChanged: (bool? v) {
              setState(() {
                fOrC = v!;
              });
            },
          ),
          Text(
            "Celsius",
            style: TextStyle(fontSize: 16),
          ),
          Radio<bool?>(
            groupValue: fOrC,
            value: true,
            onChanged: (bool? v) {
              setState(() {
                fOrC = v!;
              });
            },
          ),
        ],
      ),
    );

    Container calcBtn = Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
        ),
        child: Text(
          "Calculate",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          setState(() {
            if (fOrC) {
              output = (input * 9 / 5) + 32;
            } else {
              output = (input - 32) * (5 / 9);
            }
          });
          AlertDialog dialog = AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                fOrC
                    ? Text(
                        "${input.toStringAsFixed(2)} C : ${output.toStringAsFixed(2)} F",
                        style: TextStyle(fontSize: 16),
                      )
                    : Text(
                        "${input.toStringAsFixed(2)} F : ${output.toStringAsFixed(2)} C",
                        style: TextStyle(fontSize: 16),
                      ),
                SizedBox(height: 10),
                Text(
                  "Reamur: ${(output * 4 / 5).toStringAsFixed(2)} R",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "Kelvin: ${(output + 273.15).toStringAsFixed(2)} K",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
          showDialog(
              context: context, builder: (BuildContext context) => dialog);
        },
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            inputField,
            SizedBox(height: 20),
            tempSwitch,
            SizedBox(height: 20),
            calcBtn,
          ],
        ),
      ),
    );
  }
}
