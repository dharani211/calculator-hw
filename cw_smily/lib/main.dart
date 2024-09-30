import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shapes and Emojis App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  String _selectedShape = 'None';
  String _selectedEmoji = 'None';
  String _selectedHeart = 'None';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shapes and Emojis App'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: _selectedShape == 'None' ? null : _selectedShape,
            hint: const Text('Select Shape'),
            items: ['Square', 'Arc', 'Line'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedShape = newValue!;
                // Clear emoji and heart selections when shape changes
                _selectedEmoji = 'None';
                _selectedHeart = 'None';
              });
            },
          ),
          DropdownButton<String>(
            value: _selectedEmoji == 'None' ? null : _selectedEmoji,
            hint: const Text('Select Emoji'),
            items: ['Party', 'Smiley'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedEmoji = newValue!;
                // Clear shape and heart selections when emoji changes
                _selectedShape = 'None';
                _selectedHeart = 'None';
              });
            },
          ),
          DropdownButton<String>(
            value: _selectedHeart == 'None' ? null : _selectedHeart,
            hint: const Text('Select Heart'),
            items: ['Heart', 'Love'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedHeart = newValue!;
                // Clear shape and emoji selections when heart changes
                _selectedShape = 'None';
                _selectedEmoji = 'None';
              });
            },
          ),
          Expanded(
            child: CustomPaint(
              painter: MyPainter(
                shape: _selectedShape,
                emoji: _selectedEmoji,
                heart: _selectedHeart,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final String shape;
  final String emoji;
  final String heart;

  MyPainter({required this.shape, required this.emoji, required this.heart});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Draw selected shape
    if (shape == 'Square') {
      canvas.drawRect(
          Rect.fromLTWH(size.width / 2 - 50, size.height / 2 - 50, 100, 100),
          paint);
    } else if (shape == 'Arc') {
      paint.color = Colors.green;
      canvas.drawArc(
          Rect.fromLTWH(size.width / 2 - 75, size.height / 2 - 75, 150, 150),
          0,
          3.14,
          true,
          paint);
    } else if (shape == 'Line') {
      paint.color = Colors.red;
      canvas.drawLine(Offset(size.width / 2 - 50, size.height / 2),
          Offset(size.width / 2 + 50, size.height / 2), paint);
    }

    // Draw selected emoji
    if (emoji == 'Party') {
      _drawEmoji(canvas, size, '🎉');
    } else if (emoji == 'Smiley') {
      _drawEmoji(canvas, size, '😊');
    }

    // Draw selected heart
    if (heart == 'Heart') {
      _drawEmoji(canvas, size, '❤️');
    } else if (heart == 'Love') {
      _drawEmoji(canvas, size, '💖');
    }
  }

  void _drawEmoji(Canvas canvas, Size size, String emoji) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: emoji,
        style: const TextStyle(
            fontSize: 50, color: Color.fromARGB(255, 135, 174, 213)),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(size.width / 2 - textPainter.width / 2,
            size.height / 2 - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
