import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final Color? color;

  const TitleText({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: color ?? Colors.purple.shade300,
      ),
    );
  }
}

class SubtitleText extends StatelessWidget {
  final String text;

  const SubtitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.grey,
      ),
    );
  }
}

class NormalText extends StatelessWidget {
  final String text;
  final double? size;

  const NormalText({super.key, required this.text, this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 18,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }
}


class LinkText extends StatelessWidget {
  final String text;
  final double? size;

  const LinkText({super.key, required this.text, this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 18,
        color: Colors.purple,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
