import 'package:flutter/material.dart';

import 'hoverable_icon_button.dart';

class ChannelListItem extends StatefulWidget {
  final String channelName;
  final bool active;

  const ChannelListItem({
    required this.channelName,
    super.key,
    this.active = false,
  });

  @override
  State<StatefulWidget> createState() => _ChannelListItemState();
}

class _ChannelListItemState extends State<ChannelListItem> {
  bool _hovered = false;

  setHovered(bool hovered) {
    setState(() {
      _hovered = hovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool shouldShowControls = widget.active || _hovered;

    return Column(
      children: [
        TextButton(
          onPressed: () {
            print('Joined channel');
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color?>((
              Set<WidgetState> states,
            ) {
              if (widget.active) {
                return Colors.grey[350];
              }
              if (states.contains(WidgetState.hovered) ||
                  states.contains(WidgetState.focused) ||
                  states.contains(WidgetState.pressed)) {
                return Colors.grey[300];
              }
              return Colors.transparent;
            }),
            foregroundColor: WidgetStateProperty.resolveWith<Color?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.hovered) ||
                  states.contains(WidgetState.focused) ||
                  states.contains(WidgetState.pressed) ||
                  widget.active) {
                return Colors.grey[800];
              }
              return Colors.grey[600];
            }),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            textStyle: WidgetStateProperty.all(
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          onHover: setHovered,
          onFocusChange: setHovered,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.volume_up, size: 20),
                const SizedBox(width: 6),
                Expanded(child: Text(widget.channelName)),
                if (shouldShowControls) const SizedBox(width: 6),
                if (shouldShowControls)
                  IconButtonWithTooltip(
                    icon: Icons.person_add,
                    tooltipMessage: 'Add participant',
                    onPressed: () {
                      print('Add pressed');
                    },
                  ),
                if (shouldShowControls) const SizedBox(width: 6),
                if (shouldShowControls)
                  IconButtonWithTooltip(
                    icon: Icons.settings,
                    tooltipMessage: 'Settings',
                    onPressed: () {
                      print('Settings pressed');
                    },
                  ),
              ],
            ),
          ),
        ),
        if (widget.active) // TODO: render if any active members
          Container(
            padding: const EdgeInsets.fromLTRB(27, 0, 0, 0),
            child: const ChannelMemberList(),
          ),
      ],
    );
  }
}

class ChannelMemberList extends StatelessWidget {
  const ChannelMemberList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ChannelMemberListItem(name: 'Dhruvin', speaking: true),
        ChannelMemberListItem(name: 'Dixita', muted: true),
        ChannelMemberListItem(name: 'Chintan'),
        ChannelMemberListItem(name: 'Vatsal', muted: true, deafened: true),
      ],
    );
  }
}

class ChannelMemberListItem extends StatelessWidget {
  final String name;
  final bool speaking;
  final bool muted;
  final bool deafened;

  const ChannelMemberListItem({
    required this.name,
    this.speaking = false,
    this.muted = false,
    this.deafened = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print('Clicked on participant');
      },
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
        foregroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused) ||
              states.contains(WidgetState.pressed) ||
              speaking) {
            return Colors.grey[800];
          }
          return Colors.grey[600];
        }),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      child: Row(
        children: [
          Icon(
            speaking ? Icons.record_voice_over_outlined : Icons.person_outline,
            size: 16,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              name,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          if (muted) const SizedBox(width: 4),
          if (muted)
            const Tooltip(
              message: 'Muted',
              preferBelow: false,
              child: Icon(Icons.mic_off, size: 16),
            ),
          if (deafened) const SizedBox(width: 4),
          if (deafened)
            const Tooltip(
              message: 'Deafened',
              preferBelow: false,
              child: Icon(Icons.headset_off, size: 16),
            ),
        ],
      ),
    );
  }
}
