import 'package:flutter/material.dart';

class CommonButtons extends StatelessWidget {
  const CommonButtons({
    Key? key,
    required this.textLabel,
    required this.textColor,
    required this.backgroundColor,
    required this.onTap,
  }) : super(key: key);

  final String textLabel;
  final Color textColor;
  final Color backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 5,
        primary: backgroundColor,
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 6,
        ),
        child: Text(
          textLabel,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
    );
  }
}
