import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CW4',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;
  double _fontSize = 5.0;
  int _customIncrement = 1;
  final int _maxCounter = 100;
  final List<int> _counterHistory = [];

  void _incrementCounter() {
    if (_counter + _customIncrement <= _maxCounter) {
      setState(() {
        _counter += _customIncrement;
        _fontSize = (_counter / _maxCounter) * 30 + 20; // Adjust font size
        _counterHistory.add(_counter);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You are exceeding the limit boss!')),
      );
    }
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter -= 1;
        _fontSize = (_counter / _maxCounter) * 30 + 20;
        _counterHistory.add(_counter);
      });
    }
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _fontSize = 20;
      _counterHistory.clear();
    });
  }

  void _updateCustomIncrement(String value) {
    if (int.tryParse(value) != null) {
      setState(() {
        _customIncrement = int.parse(value);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('What is this your option is Invalid!')),
      );
    }
  }

  Color _getCounterColor() {
    if (_counter == 0) {
      return Colors.red;
    } else if (_counter > 50) {
      return Colors.green;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This should be Fontsize incrementer APP'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    '$_counter',
                    style: TextStyle(
                        fontSize: _fontSize, color: _getCounterColor()),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: _decrementCounter,
                  ),
                  const Text('Custom Increment:'),
                  SizedBox(
                    width: 50,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onSubmitted: _updateCustomIncrement,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _incrementCounter,
                  ),
                ],
              ),
              Slider(
                min: 0,
                max: _maxCounter.toDouble(),
                value: _counter.toDouble(),
                onChanged: (double value) =>
                    setState(() => _counter = value.toInt()),
                activeColor: const Color.fromARGB(255, 7, 17, 26),
                inactiveColor: const Color.fromARGB(255, 222, 134, 127),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: _resetCounter, child: const Text('Reset')),
                  ElevatedButton(
                    onPressed: () => _undoCounter(),
                    child: const Text('Undo'),
                  ),
                ],
              ),
              const Text('Counter History:'),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _counterHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${_counterHistory[index]}'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _undoCounter() {}
}
