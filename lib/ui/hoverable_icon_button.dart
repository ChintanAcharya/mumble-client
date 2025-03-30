import 'package:flutter/material.dart';

class IconButtonWithTooltip extends StatefulWidget {
  final IconData icon;
  final Function()? onPressed;
  final String tooltipMessage;
  final double iconSize;

  const IconButtonWithTooltip({
    required this.icon,
    required this.onPressed,
    required this.tooltipMessage,
    this.iconSize = 16,
    super.key,
  });

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
        constraints: const BoxConstraints(maxHeight: 24, maxWidth: 24),
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

  const IconButtonLarge({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused) ||
              states.contains(WidgetState.pressed)) {
            return Colors.grey[300];
          }
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.all(Colors.grey[800]),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        minimumSize: WidgetStateProperty.all(const Size(36, 42)),
        maximumSize: WidgetStateProperty.all(const Size(36, 42)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Icon(icon, size: 20),
      ),
    );
  }
}
