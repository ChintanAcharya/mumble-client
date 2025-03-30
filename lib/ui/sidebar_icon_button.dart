import 'package:flutter/material.dart';

class SidebarIconButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const SidebarIconButton({
    this.text,
    required this.backgroundColor,
    required this.onPressed,
    this.icon,
    super.key,
  }) : assert(text != null || icon != null);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        minimumSize: WidgetStateProperty.all(const Size(64, 64)),
        maximumSize: WidgetStateProperty.all(const Size(64, 64)),
        shape: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused) ||
              states.contains(WidgetState.pressed)) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            );
          }
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          );
        }),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child:
            icon != null
                ? Icon(icon, color: Colors.blue, size: 40)
                : Text(text!),
      ),
    );
  }
}
