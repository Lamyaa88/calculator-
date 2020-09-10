import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyCalculator());

class MyCalculator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return _Calculator();
    throw UnimplementedError();
  }
}

class _Calculator extends State<Calculator> {

//  ===============================================================================================
  String text = '';
  double num1 = 0;
  double num2 = 0;
  String result = '0';
  String finalResult = '0';
  String opr = '0';
  String preOpr = '0';
  Color btnColor =Colors.black;
//  ================================================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child:Text(text,style: TextStyle(
                  color: Colors.white,fontSize: 60,

                ),maxLines: 1,textAlign: TextAlign.right,)
                ),
              ],
            ),
            Row(
              children: <Widget>[
                button('C', btnColor, 1),
                button('+/-', btnColor, 1) ,
                button('%', btnColor, 1),
                button('/', btnColor, 1),
              ],
            ), Row(
              children: <Widget>[
                button('7', btnColor, 1),
                button('8', btnColor, 1) ,
                button('9', btnColor, 1),
                button('x', btnColor, 1),

              ],
            ),
            Row(
              children: <Widget>[
                button('4', btnColor, 1),
                button('5', btnColor, 1) ,
                button('6', btnColor, 1),
                button('-', btnColor, 1),
              ],
            ),

            Row(
              children: <Widget>[
                button('1',btnColor, 1),
                button('2', btnColor, 1) ,
                button('3', btnColor, 1),
                button('+',btnColor, 1),
              ],
            ),
            Row(
              children: <Widget>[
                button('0', btnColor, 1),
                button('.', btnColor, 1) ,
                button('=', btnColor, 0),
              ],
            )
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }

  Widget button(String btnText, Color color, int num) {
    Container container;

    if (num == 0) {
      container = Container(
        padding: EdgeInsets.only(bottom: 10),
        child: RaisedButton(
          onPressed:(){
            calculate(btnText);

          },
          child: Text(
            btnText,
            style: TextStyle(fontSize: 30,color: Colors.white),
          ),
          color: color,
          padding: EdgeInsets.only(right: 81, left: 81, bottom: 10, top: 30),
          shape: StadiumBorder(),
        ),
      );
    } else {
      container = Container(
        padding: EdgeInsets.only(bottom: 10),
        child: RaisedButton(
          onPressed: (){
            calculate(btnText);
          },
          child: Text(
            btnText,
            style: TextStyle(fontSize: 30,color: Colors.white),
          ),
          color: color,
          padding: EdgeInsets.all(20),
          shape: CircleBorder(),
        ),
      );
    }
    return container;
  }

// _____________________________________________________________________________calculate
  void calculate(txtBtn) {
    if (txtBtn == 'C') {
      text = '0';
      num1 = 0;
      num2 = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
//      ----------------------------------------------------------------
    } else if (opr == '=' && txtBtn == '=') {
      switch (preOpr) {
        case '+':
          finalResult = add();
          break;
        case '-':
          finalResult = sub();
          break;
        case 'X':
          finalResult = mul();
          break;
        case '/':
          finalResult = div();
          break;
      }
//      ----------------------------------------------------------------
    } else if (txtBtn == '+' ||
        txtBtn == '-' ||
        txtBtn == 'X' ||
        txtBtn == '/' ||
        txtBtn == '=') {
      if (num1 == 0) {
        num1 = double.parse(result);
      } else {
        num2 = double.parse(result);
      }

      switch (opr) {
        case '+':
          finalResult = add();
          break;
        case '-':
          finalResult = sub();
          break;
        case 'X':
          finalResult = mul();
          break;
        case '/':
          finalResult = div();
          break;
      }

      preOpr = opr;
      opr = txtBtn;
      result = '';

//      -------------------------------------------------------------------------------------------------------------
    } else if (txtBtn == '%') {
      result = (num1 / 100).toString();
      finalResult = result;
    } else if (txtBtn == '.') {
      if (!result.contains('.')) result += '.';
      finalResult = result;
    } else if (txtBtn == '+/-') {
      result.startsWith('-')
          ? result = result.substring(1)
          : result = '-' + result;

      finalResult = result;

//      -------------------------------------------------------------------------------------------------
    } else {
      if (result == '0')
        result = txtBtn;
      else
        result = result + txtBtn;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

//  ____________________________________________________________________________________________________________________ add/sub/mul/div/remove/

  String add() {
    result = (num1 + num2).toString();
    num1 = double.parse(result);
    return removeDicimal(result);
  }
//  ___________________________________

  String sub() {
    result = (num1 - num2).toString();
    num1 = double.parse(result);
    return removeDicimal(result);
  }
//_____________________________________

  String mul() {
    result = (num1 * num2).toString();
    num1 = double.parse(result);
    return removeDicimal(result);
  }
//  ____________________________________

  String div() {
    result = (num1 / num2).toString();
    num1 = double.parse(result);
    return removeDicimal(result);
  }
  //______________________________________

  String removeDicimal(String result) {
    if (result.contains('.')) {
      List<String> split = result.split('.');
      if (!(int.parse(split[1]) > 0)) return split[0];
    }
    return result;
  }
}
