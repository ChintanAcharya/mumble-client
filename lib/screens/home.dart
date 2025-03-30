import 'package:flutter/material.dart';
import 'package:mumble_client/ui/channel_list_item.dart';
import 'package:mumble_client/ui/hoverable_icon_button.dart';
import 'package:mumble_client/ui/sidebar_icon_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.grey[300],
              child: Column(
                children: [
                  SidebarIconButton(
                    text: 'M',
                    backgroundColor: Colors.blue,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 12),
                  SidebarIconButton(
                    text: 'L',
                    backgroundColor: Colors.blue,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 12),
                  SidebarIconButton(
                    text: '+',
                    icon: Icons.add,
                    backgroundColor: Colors.white,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SidebarIconButton(
                          icon: Icons.settings,
                          backgroundColor: Colors.white,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 270,
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'mumble.dhruvin.dev',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, color: Colors.grey[800]),
                      ],
                    ),
                  ),
                  Divider(height: 0, thickness: 2, color: Colors.grey[300]),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'CHANNELS',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButtonWithTooltip(
                          icon: Icons.add,
                          iconSize: 20,
                          onPressed: () {},
                          tooltipMessage: 'Add Channel',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          ChannelListItem(channelName: 'General'),
                          ChannelListItem(
                            channelName: 'DevDiscussions',
                            active: true,
                          ),
                          ChannelListItem(channelName: 'Minecraft'),
                          ChannelListItem(channelName: 'Kai Nam Nathi'),
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 0, thickness: 2, color: Colors.grey[300]),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.signal_cellular_alt,
                                    size: 20,
                                    color: Colors.green[700],
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    'Voice Connected',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'DevDiscussions',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Tooltip(
                          message: 'Disconnect',
                          preferBelow: false,
                          child: IconButtonLarge(
                            icon: Icons.phone_disabled,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 0, thickness: 2, color: Colors.grey[300]),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Chintan',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                        Tooltip(
                          message: 'Mute',
                          preferBelow: false,
                          child: IconButtonLarge(
                            icon: Icons.mic,
                            onPressed: () {},
                          ),
                        ),
                        Tooltip(
                          message: 'Deafen',
                          preferBelow: false,
                          child: IconButtonLarge(
                            icon: Icons.headset,
                            onPressed: () {},
                          ),
                        ),
                        Tooltip(
                          message: 'Settings',
                          preferBelow: false,
                          child: IconButtonLarge(
                            icon: Icons.settings,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.tag, size: 24, color: Colors.grey[800]),
                        const SizedBox(width: 4),
                        Text(
                          'DevDiscussions',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 0, thickness: 2, color: Colors.grey[300]),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: MessageList(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Message #DevDiscussions',
                      ),
                      minLines: 1,
                      maxLines: 7,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  final List<String> messages = ['Hello everyone!', 'Hello', 'Hello'];
  final List<String> users = ['Dhruvin', 'Dixita', 'Chintan'];
  final List<String> timestamps = ['17:05', '17:07', '17:10'];
  final List<Color?> colors = [
    Colors.purple[700],
    Colors.red[700],
    Colors.brown[700],
  ];

  MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: OverflowBox(
        child: ListView.builder(
          itemCount: messages.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return ChatMessage(
              username: users[index],
              timestamp: timestamps[index],
              message: messages[index],
              color: colors[index],
              key: ValueKey(index),
            );
          },
        ),
      ),
    );
  }
}

class ChatMessage extends StatefulWidget {
  final String username;
  final String timestamp;
  final String message;
  final Color? color;

  const ChatMessage({
    super.key,
    required this.username,
    required this.timestamp,
    required this.message,
    this.color,
  });

  @override
  State<StatefulWidget> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  bool _hovered = false;

  void setHovered(bool hovered) {
    setState(() {
      _hovered = hovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) => setHovered(true),
      onExit: (_) => setHovered(false),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: _hovered ? Colors.grey[100] : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SelectableText(
                  widget.timestamp,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
                const SizedBox(width: 4),
                SelectableText(
                  widget.username,
                  style: TextStyle(
                    color: widget.color,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 4),
            Flexible(
              child: SelectableText(
                widget.message,
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
