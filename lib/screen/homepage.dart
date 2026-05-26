import 'package:flutter/material.dart';
import 'package:lucaschatbot/screen/MoodCheckin.dart';
import '../color_scheme.dart';

class HomePage extends StatefulWidget{

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
 Moodcheckin moodcheckin = Moodcheckin();
 bool maybeButton = false;
 String healthtips = "";
 
  @override
  Widget build(BuildContext context) {
    final mood = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
    backgroundColor: Color(0xFF060F1A),
    
     body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
         Container(
           alignment: Alignment.topLeft,
           child: Text("Today's mood: $mood",
                   style: TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 129, 152, 175)
                   ),
                   ),
         ),
         SizedBox(height: 5,),
         Container(
          alignment: Alignment.topLeft,
           child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/Checkin');
            },
            child: Text(
              "Change mood",
              style: TextStyle(
               fontSize: 14,
               color: Color.fromARGB(255, 129, 152, 175)
              ),
              ),
           ),
         ),

        SizedBox(height: 40,),
        
        if(mood == "Happy") ...[
          _moodRecommendationCard(
            context, 
            mood,
            "You're happy today, I'm proud of you", 
            "Writing helps you to maintain mood.", 
            "Begin Writing", 
            '/Chatbot')
        ]
        else if(mood == "Normal") ...[
          _moodRecommendationCard(
            context, 
            mood,
            "So a normal day is it?", 
            "Sometimes we forget to notice the small things that truly matters. Writing down a moment or feeling that lingered for a bit than it should have helps you notice those small things.", 
            "Begin Writing", 
            '/Breathing')
        ]
        else if(mood == "Unhappy") ...[
          _moodRecommendationCard(
            context, 
            mood,
            "You seem sad today", 
            "Writing down what bothers you helps lighten your mood. \nTalking about your feelings definitely helps too.", 
            "Talk with Lucas", 
            '/Chatbot')
        ]
        else if(mood == "Stressed") ...[
          _moodRecommendationCard(
            context, 
            mood,
            "You seemed overwhelmed today.?", 
            "Take a short pause and breathe. Small moment of calm can help reset you mind.", 
            "Begin Exercise", 
            '/Breathing')
        ],

        SizedBox(height: 20),

        
        GestureDetector(
          onTap: () {
            setState(() {
              if(healthtips == "") {
                healthtips = "tip";
              }
              else {healthtips = ""; }
            });
          },
          child: Text("Daily health tips",
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFFB5D4F4),
          ),
          ),
        ),

         Text(
          healthtips,
          style: TextStyle(
             fontSize: 10,
             color: Color(0xFFB5D4F4),
          ),
         )


        ],
      ),
      )

    );
  }

  Widget _moodRecommendationCard(BuildContext context,String mood, String feeling, String message, String action, String routename) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
        color: AppColorScheme.elevated, 
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF103A5C)),
      ),
        
              //TEXT
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Text(feeling,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                   ),
                  ),
                  
                  SizedBox(height: 30),

                  Text(message,
                  style: TextStyle(
                    color: Color(0xFFB5D4F4),
                   ),
                 ),

                 SizedBox(height: 30),

                 Text("Try starting with this: ",
                  style: TextStyle(
                    color: Color(0xFFB5D4F4),
                   ),
                 ),

                  SizedBox(height: 30),

                  _actionButton(action, routename),
                
                SizedBox(height: 30),

                  GestureDetector(
                    onTap: () {
                     setState(() {
                       maybeButton = !maybeButton;
                     });
                    },

                    child: Text("Maybe this could help: ",
                     style: TextStyle(
                       color: Color(0xFFB5D4F4),
                     ),
                    ),
                ),

                if(maybeButton == true) ...[
                  if(action == "Begin Exercise") ...[
                       SizedBox(height: 10),
                      _actionButton("Try Writing", '/Chatbot'),
                       SizedBox(height: 10),
                      _actionButton("Talk with Lucas", '/Chatbot'),
                  ]
                  else if(action == "Talk with Lucas") ...[
                      SizedBox(height: 10),
                      _actionButton("Try Writing", '/Chatbot'),
                       SizedBox(height: 10),
                      _actionButton("Try Exercise", '/Breathing'),
                  ]
                  else if(action == "Begin Writing") ...[
                      SizedBox(height: 10),
                      _actionButton("Talk with Lucas", '/Chatbot'),
                       SizedBox(height: 10),
                      _actionButton("Try Exercise", '/Breathing'),
                  ]

                ],
            
                  
                ],
            )
     );
  }

Widget _actionButton(String action, String routename) {
 return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
       onPressed: () {
        Navigator.pushNamed(context, routename);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF0B1929),
        foregroundColor: const Color(0xFFB5D4F4),
        side: BorderSide(color: Color(0xFF1D3A5C)),
      ),
      child: Text(action,
       style: TextStyle(
       color: Color(0xFFB5D4F4),
              ),
          ),
      ),
 );
}

}