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
    Key? key,
  })  : assert(text != null || icon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          textStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          minimumSize: MaterialStateProperty.all(const Size(64, 64)),
          maximumSize: MaterialStateProperty.all(const Size(64, 64)),
          shape: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed)) {
              return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16));
            }
            return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32));
          })),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: icon != null
            ? Icon(icon, color: Colors.blue, size: 40)
            : Text(text!),
      ),
    );
  }
}
