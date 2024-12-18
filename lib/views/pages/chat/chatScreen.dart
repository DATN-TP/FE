import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/views/pages/chat/chatBotService.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final ChatBotService _chatBotService = ChatBotService();
  final ScrollController _scrollController = ScrollController();
  
  // Danh sách các câu hỏi gợi ý
  final List<Map<String, String>> _suggestedQuestions = [
    { 'Phí quản lý căn hộ sử dụng thang máy là bao nhiêu?': 'Nếu một căn hộ có sử dụng thang máy thì phí quản lý sẽ là bao nhiêu?', },
    { 'Phí quản lý căn hộ không sử dụng thang máy là bao nhiêu?': 'Tôi muốn biết mức phí quản lý cho căn hộ không sử dụng thang máy là bao nhiêu?', },
    { 'Giá nước được tính thế nào?': 'Giá nước được tính thế nào?', },
  ];

  // Hàm gửi tin nhắn
  void _sendMessage(String text) async {
    if (text.isNotEmpty) {
      _controller.clear();

      // Thêm tin nhắn của người dùng vào danh sách
      setState(() {
        _messages.add({'sender': 'user', 'message': text});
      });

      _messages.add({'sender': 'ai', 'message': "Đang trả lời ..."});
      
      // Cuộn xuống cuối danh sách tin nhắn
      _scrollToBottom();

      // Gửi yêu cầu tới OpenAI và nhận phản hồi
      String aiResponse = await _chatBotService.getResponse(text);
      
      // Xóa tin nhắn "Đang trả lời ..."
      _messages.removeWhere((element) => element['message'] == "Đang trả lời ...");

      // Thêm phản hồi của AI
      setState(() {
        _messages.add({'sender': 'ai', 'message': aiResponse});
      });

      // Cuộn xuống cuối sau khi thêm tin nhắn của AI
      _scrollToBottom();
    }
  }

  // Hàm cuộn xuống cuối danh sách tin nhắn
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    String aiResponse = await _chatBotService.getResponse('Chào');
    
    setState(() {
      _messages.add({'sender': 'ai', 'message': aiResponse});
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat bot AI', style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: ColorApp().cl1,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _suggestedQuestions.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorApp().cl1),
                            borderRadius: BorderRadius.circular(36),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          _sendMessage(_suggestedQuestions[index].values.first);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorApp().white,
                        ),
                        child: Text(
                          _suggestedQuestions[index].keys.first,
                          style: TextStyle(color: ColorApp().cl1),
                        ),
                      ),
                  );
                },
              ),
            ),
          ),
          // Phần hiển thị tin nhắn
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: _messages[index]['sender'] == 'user'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: _messages[index]['sender'] == 'user'
                          ? ColorApp().cl1
                          : Colors.grey,
                      borderRadius: _messages[index]['sender'] == 'user' 
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ) 
                          : const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                    ),
                    child: Text(
                      _messages[index]['message']!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Nhập tin nhắn...',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorApp().cl1),
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorApp().cl1),
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: ColorApp().cl1),
                  onPressed: () {
                    _sendMessage(_controller.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
