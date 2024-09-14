import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  MessagePage({super.key});

  final List<Map<String, dynamic>> messages = [
    {'message': 'Hello, how are you?', 'time': '10:00 AM', 'isMe': true},
    {'message': 'I am fine, thank you.', 'time': '10:00 AM', 'isMe': false},
    {'message': 'What are you doing?', 'time': '10:00 AM', 'isMe': true},
    {
      'message': 'I am working on my project.',
      'time': '10:00 AM',
      'isMe': false
    },
    {
      'message': 'Can you help me with my project?',
      'time': '10:00 AM',
      'isMe': true
    },
    {'message': 'Sure, I can help you.', 'time': '10:00 AM', 'isMe': false},
    {'message': 'Thank you so much.', 'time': '10:00 AM', 'isMe': true},
    {'message': 'You are welcome.', 'time': '10:00 AM', 'isMe': false},
    {'message': 'Goodbye.', 'time': '10:00 AM', 'isMe': true},
    {'message': 'Goodbye.', 'time': '10:00 AM', 'isMe': false},
  ];

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
        );
      }
    });
  }

  void _onSendMessage() {
    final messageText = _textEditingController.text.trim();
    if (messageText.isEmpty) return;

    final time =
        DateTime.now().toString(); // Định dạng thời gian tùy theo nhu cầu
    final newMessage = {
      'message': messageText,
      'time': time,
      'isMe': true,
    };

    setState(() {
      widget.messages.add(newMessage);
    });

    _textEditingController.clear();
    _scrollToBottom();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff712BBC), Color(0xff7AA0D5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text('Messages'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(bottom: 50.0),
              itemCount: widget.messages.length,
              itemBuilder: (context, index) {
                final message = widget.messages[index];
                final isMe = message['isMe'];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue[300] : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message['message'] ?? '',
                              style: TextStyle(
                                color: isMe ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              message['time'] ?? '',
                              style: TextStyle(
                                color: isMe ? Colors.white70 : Colors.black54,
                                fontSize: 10.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Enter your message...',
                ),
                onSubmitted: (_) => _onSendMessage(),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: _onSendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
