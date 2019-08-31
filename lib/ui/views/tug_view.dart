import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_gorgeous_login/core/models/user.dart';
import 'package:the_gorgeous_login/ui/widgets/button.dart';


class TUGView extends StatelessWidget {
  // Build method
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is setting the primary color of the app to Blue.
        primarySwatch: Colors.blue,
      ),

      home: new TugTestPage(title: 'TUG Test'),
    );
  }
}

class TugTestPage extends StatefulWidget {
  TugTestPage({Key key, this.title}) : super(key: key);
  final String title; // => Flutter Home Demo Page
  @override
  _TugTestPageState createState() => new _TugTestPageState();
}

class _TugTestPageState extends State<TugTestPage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      _counter++;
//    });
//  }

  Timer _timer;
  int _counter = 10;
  String _counterText = '';
  String _buttonTitle = "BEGIN";
  String _actionDescription = 'Press BEGIN to start.';

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _buttonTitle = 'BEGIN';
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_counter < 1) {
            timer.cancel();
            _buttonTitle = 'BEGIN';
            _counter = 10;
            _counterText = 'Done';
            _actionDescription = 'Press BEGIN for another try.';

          } else {
            _counterText = _counter.toString();
            _counter = _counter - 1;
            _buttonTitle = 'STOP';
            _actionDescription = 'Press STOP to stop data collection.';
          }
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body:

      Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('The Timed Up and Go test (TUG) is a simple test used to assess a person\'s mobility and requires both static and dynamic balance. '
                      'It uses the time that a person takes to rise from a chair, walk three meters, turn around, walk back to the chair, and sit down'
                  )],
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: new Image(
                    width: 330.0,
                    height: 200.0,
                    fit: BoxFit.fill,
                    image: new AssetImage('assets/img/tug_test.jpg')),
              ),
              SizedBox(
                height: 20,
              ),

              Button(
                label: '$_buttonTitle',
                onPressed: (){
                  startTimer();
                },
                labelSize: 18,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: new Column(
                    children: <Widget>[
                      new Text(
                        '$_actionDescription\n',
                      ),
                      new Text(
                        '$_counterText',
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),

//      floatingActionButton: new FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: new Icon(Icons.add),
//      ),
    );
  }
}

