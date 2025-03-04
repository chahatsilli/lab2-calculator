import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: const CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  double _num1 = 0;
  double _num2 = 0;
  String? _operator;
  bool _isNewInput = false;

  void _onDigitPress(String digit) {
    setState(() {
      if (_isNewInput || _display == '0') {
        _display = digit;
        _isNewInput = false;
      } else {
        _display += digit;
      }
    });
  }

  void _onOperatorPress(String operator) {
    setState(() {
      _num1 = double.parse(_display);
      _operator = operator;
      _isNewInput = true;
    });
  }

  void _calculateResult() {
    setState(() {
      _num2 = double.parse(_display);
      double result = 0;

      switch (_operator) {
        case '+':
          result = _num1 + _num2;
          break;
        case '-':
          result = _num1 - _num2;
          break;
        case '*':
          result = _num1 * _num2;
          break;
        case '/':
          result = _num2 != 0 ? _num1 / _num2 : double.nan;
          break;
      }

      _display = result.toString();
      _isNewInput = true;
    });
  }

  void _clearDisplay() {
    setState(() {
      _display = '0';
      _num1 = 0;
      _num2 = 0;
      _operator = null;
      _isNewInput = false;
    });
  }

  Widget _buildButton(String text, Function()? onPressed, {bool isOperator = false}) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // Dark color for buttons
          foregroundColor: Colors.white, // Text color
          padding: const EdgeInsets.all(20),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                _display,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(children: [
            _buildButton('7', () => _onDigitPress('7')),
            _buildButton('8', () => _onDigitPress('8')),
            _buildButton('9', () => _onDigitPress('9')),
            _buildButton('/', () => _onOperatorPress('/')),
          ]),
          Row(children: [
            _buildButton('4', () => _onDigitPress('4')),
            _buildButton('5', () => _onDigitPress('5')),
            _buildButton('6', () => _onDigitPress('6')),
            _buildButton('*', () => _onOperatorPress('*')),
          ]),
          Row(children: [
            _buildButton('1', () => _onDigitPress('1')),
            _buildButton('2', () => _onDigitPress('2')),
            _buildButton('3', () => _onDigitPress('3')),
            _buildButton('-', () => _onOperatorPress('-')),
          ]),
          Row(children: [
            _buildButton('0', () => _onDigitPress('0')),
            _buildButton('C', _clearDisplay),
            _buildButton('=', _calculateResult),
            _buildButton('+', () => _onOperatorPress('+')),
          ]),
        ],
      ),
    );
  }
}




