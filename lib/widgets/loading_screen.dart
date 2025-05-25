import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingScreen extends StatefulWidget {
  final Future<void> Function() loadingTask;
  final String routeName;

  const LoadingScreen(
      {super.key, required this.routeName, required this.loadingTask});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final List<String> messages = [
    "Revving up...",
    "Almost there...",
    "Tuning the engine...",
    "Checking tire pressure...",
    "Fueling up...",
    "Starting the ignition...",
    "Warming up the turbo...",
    "Engaging launch control...",
    "Fastening seat belts...",
    "Final pit stop..."
  ];

  late Timer _timer;
  String _currentMessage = "Loading...";

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentMessage = (messages..shuffle()).first;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startLoadingTask();
    });
  }

  void _startLoadingTask() async {
    try {
      await widget.loadingTask();
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(widget.routeName);
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${error.toString()}"),
          backgroundColor: Colors.red,
        ),
      );

      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _currentMessage,
              style: const TextStyle(
                color: Colors.deepPurple,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              width: 80,
              height: 80,
              child: LoadingIndicator(
                indicatorType: Indicator.ballZigZagDeflect,
                colors: [Colors.deepPurpleAccent],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
