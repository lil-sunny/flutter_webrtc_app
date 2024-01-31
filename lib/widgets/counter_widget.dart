import "package:flutter/material.dart";

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext content) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Counter Widget'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Counter value:',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  '$_counter',
                  style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: _incrementCounter, child: Icon(Icons.add)),
                    SizedBox(width: 16.0),
                    ElevatedButton(
                        onPressed: _decrementCounter,
                        child: Icon(Icons.remove)),
                  ],
                )
              ]),
        ));
  }
}
