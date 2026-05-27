import 'package:flutter/material.dart';
import 'package:lucaschatbot/services/ai_services.dart';
import '../color_scheme.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreen();
}

class _ChatBotScreen extends State<ChatBotScreen> {

  final AIService aiService = AIService();
  final TextEditingController messageController =
      TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    List<Map<String, dynamic>> messages = [];
  final ScrollController _scrollController = ScrollController();

  
    
   Future<void> sendMessage() async{
    //If empty user input, return
    if (messageController.text.trim().isEmpty) return;
    String userInput = messageController.text;

    setState(() {
      messages.add({
        "text": userInput,
        "isUser": true,
      });
    });
    messageController.clear();

    //Responsible for the AI replies.
     String aiReply = await aiService.getResponse(userInput);
      setState(() {
        messages.add({
          "text": aiReply,
          "isUser": false,
      });
      });
      _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

 @override
  void dispose(){
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // default screen, heart icon shown before any messages 
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColorScheme.accentRim2.withValues(alpha: .35), width: 2),
            ),
            child: Center(
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColorScheme.surface,
                  border: Border.all(
                    color: AppColorScheme.accentRim2.withValues(alpha: .6),
                    width: 1.5,
                  ),
                ),
                child: Icon(Icons.favorite, color: AppColorScheme.accentRim2, size: 44,),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'How are you feeling today?',
            style: TextStyle(
              color: Colors.white.withValues(alpha: .45),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

   // This is the function responsible for the alighment of chatbubble
  Widget _buildChatBubble(int index) {
    bool isUser = messages[index]["isUser"];
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75,),
        decoration: BoxDecoration(
          color: isUser ? AppColorScheme.accent : AppColorScheme.elevated,
          border: Border.all(color: AppColorScheme.border, width: 0.6),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
        ),
        child: Text(
          messages[index]["text"],
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColorScheme.bg,
      appBar: AppBar(
        backgroundColor: AppColorScheme.surface,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFFB5D4F4),
        ),
        title: const Text(
          'Lucas',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            letterSpacing: 0.4
          ),
        ),
        centerTitle: true,
       actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: const CircleAvatar(
                  backgroundColor: AppColorScheme.accentRim2,
                  radius: 18,
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
                tooltip: 'Profile',
                onPressed: () {},
              ),
            ),
          ],
        ),
    
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? _buildEmptyState()  // ← heart icon when no messages
                : ListView.builder(   // ← chat bubbles when messages exist
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) => _buildChatBubble(index),
                  ),
          ),
          // Input bar
          Container(
            color: AppColorScheme.surface,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    style: const TextStyle(color: Colors.white),
                    onSubmitted: (_) => sendMessage(),
                    decoration: InputDecoration(
                      fillColor: AppColorScheme.elevated,
                      filled: true,
                      hintText: "Ask something...",
                      hintStyle: TextStyle(color: Colors.white.withValues(alpha: .35)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: AppColorScheme.border, width: 0.8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: AppColorScheme.accentRim, width: 1.2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: sendMessage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColorScheme.accentRim2,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(14),
                  ),
                  child: const Icon(Icons.send, color: Colors.white, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}