import 'package:flutter/material.dart';
import 'pong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pong',
      theme: ThemeData(

        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Pong'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: const SafeArea(child: Pong()),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
