import 'package:flutter/material.dart';

class IconButtonWithTooltip extends StatefulWidget {
  final IconData icon;
  final Function()? onPressed;
  final String tooltipMessage;
  final double iconSize;

  const IconButtonWithTooltip(
      {required this.icon,
      required this.onPressed,
      required this.tooltipMessage,
      this.iconSize = 16,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _IconButtonWithTooltipState();
}

class _IconButtonWithTooltipState extends State<IconButtonWithTooltip> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltipMessage,
      preferBelow: false,
      child: IconButton(
        icon: Icon(widget.icon),
        iconSize: widget.iconSize,
        padding: const EdgeInsets.all(0),
        splashRadius: 12,
        constraints: const BoxConstraints(
          maxHeight: 24,
          maxWidth: 24,
        ),
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onPressed: widget.onPressed,
      ),
    );
  }
}

class IconButtonLarge extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const IconButtonLarge({required this.icon, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed)) return Colors.grey[300];
            return Colors.transparent;
          },
        ),
        foregroundColor: MaterialStateProperty.all(Colors.grey[800]),
        textStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        minimumSize: MaterialStateProperty.all(const Size(36, 42)),
        maximumSize: MaterialStateProperty.all(const Size(36, 42)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Icon(icon, size: 20),
      ),
    );
  }
}
