import 'package:flutter/material.dart';
import 'package:lucaschatbot/services/ai_services.dart';
import 'BreathingScreen.dart';
import 'login_screen.dart';

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

  final List<Map<String, dynamic>> _menuItemsTop = [ //naka list ung menu ng burger menu
    {'icon': Icons.home_outlined, 'label': 'Home'},
    {'icon': Icons.self_improvement, 'label': 'Breathing'},
    {'icon': Icons.self_improvement, 'label': 'Login'},
    {'icon': Icons.bookmark_border, 'label': 'Saved'},
    {'icon': Icons.settings_outlined, 'label': 'Settings'},
    {'icon': Icons.help_outlined, 'label': 'Help & Support'},
    {'icon': Icons.privacy_tip_outlined, 'label': 'Privacy'},
    {'icon': Icons.logout, 'label': 'Log Out'},
  ];

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
  }

 @override
  void dispose(){
    messageController.dispose();
    super.dispose();
  }

@override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF2E2A3D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A4460),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          title: null,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                'User',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.72,
          backgroundColor: const Color(0xFFD6D3E0),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Column(
            children: [
              Container(
                height: 130,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF8B85A8),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: const BoxDecoration(
                            color: Color(0xFF5C5470),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Username',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ..._menuItemsTop.map((item) => _buildMenuItem(item)),
                  ],
                ),
              ),

              Container(
                color: const Color(0xFF4A4460),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF8B85A8),
                    child: Icon(Icons.info_outline, color: Colors.white, size: 20),
                  ),
                  title: const Text(
                    'About Herzpunkt',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
        body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,

 //This is the function responsible for the alighment of chatbubble
              itemBuilder: (context, index) {
                bool isUser = messages[index]["isUser"];
                return Align(
                  alignment: 

                      //If isUser true/false: Align it in right/left
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(

                        //If isUser true/false: Color blue/grey
                       color: isUser ? Colors.blue : const Color.fromARGB(255, 232, 154, 235),
                       borderRadius: BorderRadius.circular(12),
                        ),
                     child: Text(
                       messages[index]["text"],
                       style: const TextStyle(fontSize: 16),
                       ),
                ),
               );
             },
            ),
          ),
          //Message bar or something
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Ask something...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: sendMessage,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
        
     );
  }

    Widget _buildMenuItem(Map<String, dynamic> item){
      return Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFBFBBD1), width: 0.8),
          ),
        ),
        child: ListTile(
          tileColor: const Color(0xFFD6D3E0),
          leading: Icon(
            item['icon'] as IconData,
            color: const Color(0xFF4A4460),
            size: 22,
          ),
          title: Text(
            item['label'] as String,
            style: const TextStyle(
              color: Color(0xFF2E2A3D),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: Color(0xFF8B85A8),
            size: 20,
          ),
          onTap: (){
            Navigator.pop(context);
            if(item['label'] == "Breathing") {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => const BreathingScreen(), 
                        ),
                      );
                    }
            else if(item['label'] == "Login") {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => const Login(), 
                        ),
                      );
                    }        
            // for navigation
          },
        ),
      );
    }
}