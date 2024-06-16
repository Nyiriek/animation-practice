import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FadeTransitionDemo(),
    );
  }
}

class FadeTransitionDemo extends StatefulWidget {
  const FadeTransitionDemo({super.key});

  @override
  _FadeTransitionDemoState createState() => _FadeTransitionDemoState();
}

class _FadeTransitionDemoState extends State<FadeTransitionDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFadedOut = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFade() {
    if (_isFadedOut) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _isFadedOut = !_isFadedOut;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fade Transition Demo'),
      ),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Container(
            width: 200,
            height: 200,
            color: const Color.fromARGB(183, 61, 242, 25),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleFade,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
