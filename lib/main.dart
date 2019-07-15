import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'models/TimeTask.dart';

final timeTask = TimeTask();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobx Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'MobX'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(
        Duration(seconds: 5), (Timer t) => timeTask.updateTime());
  }

  @override
  void dispose() {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Current time in ms updating every 5sec:',
            ),
            /********OBSERVER, KI OB VSAKI SPREMEMBI SPREMENLJIVKE POSODOBI WIDGET. KLIC NA METODO Z ACTION KONOTACIJO, PROŽI SPREMEMBO.**/
            Observer(
              builder: (_) => Text(
                    '${timeTask.time}',
                    style: Theme.of(context).textTheme.display1,
                  ),
            ),
            Text(
              'Starting time (non observable) ${timeTask.nonObservableTime}',
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
