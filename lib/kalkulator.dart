import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = "0";
  String output = "0";
  String expression = "";
  double inputFontSize = 38.0;
  double outputFontSize = 48.0;

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        input = "0";
        output = "0";
        inputFontSize = 38.0;
        outputFontSize = 48.0;
      } else if (buttonText == "Del") {
        inputFontSize = 48.0;
        outputFontSize = 38.0;
        input = input.substring(0, input.length - 1);
        if (input == "") {
          input = "0";
        }
      } else if (buttonText == "=") {
        inputFontSize = 38.0;
        outputFontSize = 48.0;

        expression = input;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          output = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          output = "Error";
        }
      } else {
        inputFontSize = 48.0;
        outputFontSize = 38.0;
        if (input == "0") {
          input = buttonText;
        } else {
          input = input + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator 1.0')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              input,
              style: TextStyle(fontSize: inputFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              output,
              style: TextStyle(fontSize: outputFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Colors.redAccent),
                      buildButton("Del", 1, Colors.blue),
                      buildButton("÷", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.black54),
                      buildButton("8", 1, Colors.black54),
                      buildButton("9", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.black54),
                      buildButton("5", 1, Colors.black54),
                      buildButton("6", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.black54),
                      buildButton("2", 1, Colors.black54),
                      buildButton("3", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.black54),
                      buildButton("0", 1, Colors.black54),
                      buildButton("00", 1, Colors.black54),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.redAccent),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
