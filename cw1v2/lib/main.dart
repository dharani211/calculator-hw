import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CW1V2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.lightBlueAccent,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isImageOne = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleImage() {
    setState(() {
      _isImageOne = !_isImageOne;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
      _isImageOne = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image and Increment App - CW1V2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              _isImageOne ? 'assets/image1.jpg' : 'assets/image2.jpg',
              width: 400,
              height: 400,
            ),
            const SizedBox(height: 20),
            Text(
              'Counter: $_counter',
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: const Text('+'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _toggleImage,
              child: const Text('Toggle Image'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
