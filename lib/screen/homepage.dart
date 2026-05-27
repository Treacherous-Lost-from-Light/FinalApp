import 'package:flutter/material.dart';
import '../color_scheme.dart';

class HomePage extends StatefulWidget{

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
 bool maybeButton = false;
 String healthtips = "";
 
  @override
  Widget build(BuildContext context) {
    final mood = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
    backgroundColor: Color(0xFF060F1A),
    
     body: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
           alignment: Alignment.topLeft,
           child: Text("Welcome Back",
                   style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 129, 152, 175)
                   ),
                   ),
         ),
         SizedBox(height: 5,),
          
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

        SizedBox(height: 30,),
        
        if(mood == "Happy") ...[
          _moodRecommendationCard(
            context, 
            mood,
            "You're happy today, I'm proud of you", 
            "Writing helps you to maintain mood.", 
            "Begin Writing", 
            '/Journal')
        ]
        else if(mood == "Normal") ...[
          _moodRecommendationCard(
            context, 
            mood,
            "So a normal day is it?", 
            "Sometimes we forget to notice the small things that truly matters. Writing down a moment or feeling that lingered for a bit than it should have helps you notice those small things.", 
            "Begin Writing", 
            '/Journal')
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
            "You seemed overwhelmed today.", 
            "Take a short pause and breathe. Small moment of calm can help reset you mind.", 
            "Begin Exercise", 
            '/Breathing')
        ],
        
        Spacer(),
        
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/Aboutus');
          },
          child: Text("About us",
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFFB5D4F4),
          ),
          ),
        ),

        

        ],
      ),
      )

    );
  }

  Widget _moodRecommendationCard(BuildContext context,String mood, String feeling, String message, String action, String routename) {
   Color moodColor = AppColorScheme.accentRim2;
   IconData moodIcon = Icons.favorite;
   if (mood == "Happy") {
   moodColor = Color.fromARGB(150, 247, 219, 97);
   moodIcon = Icons.wb_sunny;
   }

   else if (mood == "Normal") {
   moodColor = Color(0xFF90A4AE);
   moodIcon = Icons.cloud;
   }

   else if (mood == "Unhappy") {
   moodColor = Color.fromARGB(255, 96, 95, 170);
   moodIcon = Icons.cloud_queue;
   }

   else if (mood == "Stressed") {
   moodColor = Color.fromARGB(255, 90, 76, 116);
   moodIcon = Icons.nights_stay;
   }
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
        color: AppColorScheme.elevated, 
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: moodColor, width: 1.5),
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
                  
                  SizedBox(height: 20),

                  Text(message,
                  style: TextStyle(
                    color: Color(0xFFB5D4F4),
                   ),
                 ),

                 SizedBox(height: 20),

                 Text("Try starting with this: ",
                  style: TextStyle(
                    color: Color(0xFFB5D4F4),
                   ),
                 ),

                  SizedBox(height: 20),

                  _actionButton(action, routename, moodColor),
                
                SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                     setState(() {
                       maybeButton = !maybeButton;
                     });
                    },

                    child: Text("Maybe this could help: ",
                     style: TextStyle(
                       color: Colors.white54,
                     ),
                    ),
                ),

                if(maybeButton == true) ...[
                  if(action == "Begin Exercise") ...[
                       SizedBox(height: 10),
                      _actionButton("Try Writing", '/Journal', moodColor),
                       SizedBox(height: 10),
                      _actionButton("Talk with Lucas", '/Chatbot', moodColor),
                  ]
                  else if(action == "Talk with Lucas") ...[
                      SizedBox(height: 10),
                      _actionButton("Try Writing", '/Journal', moodColor),
                       SizedBox(height: 10),
                      _actionButton("Try Exercise", '/Breathing', moodColor),
                  ]
                  else if(action == "Begin Writing") ...[
                      SizedBox(height: 10),
                      _actionButton("Talk with Lucas", '/Chatbot', moodColor),
                       SizedBox(height: 10),
                      _actionButton("Try Exercise", '/Breathing', moodColor),
                  ]

                ],
            
                  
                ],
            )
     );
  }

Widget _actionButton(String action, String routename,  Color moodColor,) {
 return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
       onPressed: () {
        Navigator.pushNamed(context, routename);
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 48),
        backgroundColor: moodColor.withValues(alpha: .15),
        foregroundColor: const Color(0xFFB5D4F4),
        side: BorderSide(color: moodColor),
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