import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final bool max;

  const CustomButton({
    super.key,
    this.text,
    this.icon,
    required this.onPressed,
    this.color,
    this.textColor,
    this.max = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.purple.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
      child: Row(
        mainAxisSize: max ? MainAxisSize.max : MainAxisSize.min,
        children: [
          if (text != null)
            Text(
              text!,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (text != null && icon != null) const SizedBox(width: 10),
          if (icon != null) Icon(icon, color: textColor ?? Colors.white),
        ],
      ),
    );
  }
}
