import 'package:flutter/material.dart';
import '../color_scheme.dart';


class Journal extends StatefulWidget{
  const Journal({super.key});

  @override
  State<Journal> createState() => _Journal();
}

class _Journal extends State<Journal> {

   final TextEditingController messageController =
      TextEditingController();
   final TextEditingController titleController =
      TextEditingController();

  List<Map<String, String>> notes = [];
  
  void saveNote() {
    if(messageController.text.trim().isEmpty) return;
    String titleInput = titleController.text.trim().isEmpty ? "untitled" : titleController.text;
    String userInput = messageController.text;

    setState(() {
      notes.add({
        "title": titleInput,
        "text": userInput,
      });
    });
    messageController.clear();
    titleController.clear();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorScheme.bg,
      appBar: AppBar(
        backgroundColor: AppColorScheme.surface,
         elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                  Text("Journal",
                  style: TextStyle(
                   color: Color(0xFFB5D4F4),
                      )
                  ),
          
                Text("Your thoughts are safe here",
                style: TextStyle(
                 color: Color(0xFFB5D4F4),
                     )
                 ),
              ],
            ),
          ),
          

          Container(
            color: AppColorScheme.surface,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              children: [

                TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white),
                  
                  decoration: InputDecoration(
                    fillColor: AppColorScheme.elevated,
                    filled: true,
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.white.withValues(alpha: .35)),
                  ),
                  
                  ),

                SizedBox(height: 20),

                TextField(
                  controller: messageController,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 10,

                  decoration: InputDecoration(
                    fillColor: AppColorScheme.elevated,
                    filled: true,
                    hintText: "Write here",
                    hintStyle: TextStyle(color: Colors.white.withValues(alpha: .35)),
                  ),
                  ),

                 SizedBox(height: 30,),
                  ElevatedButton(
                    onPressed: saveNote,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColorScheme.accentRim2,
                      padding: const EdgeInsets.all(14),
                    ),
                     child: Text("Save note",
                     style: TextStyle(
                      color: Colors.white,
                     ),
                     ),
                  ),
              
 

              ],
            ),
          ),

        ],
      ),
    );
  }




}