import 'package:flutter/material.dart';
import 'package:lucaschatbot/screen/BreathingScreen.dart';
import 'package:lucaschatbot/screen/ChatbotScreen.dart';
import 'package:lucaschatbot/screen/Homepage.dart';
import 'package:lucaschatbot/screen/MoodCheckin.dart';
import 'package:lucaschatbot/screen/journal.dart';
import 'package:lucaschatbot/screen/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

 const MyApp({super.key});

 @override
 Widget build(BuildContext context) {
  return MaterialApp(
    initialRoute: '/splash',
    routes: {
      '/splash': (context) => const SplashScreen(),
      '/': (context) => HomePage(),
      '/Chatbot': (context) => const ChatBotScreen(), 
      '/Breathing': (context) => const BreathingScreen(),
      '/Checkin': (context) => const Moodcheckin(),
      '/Journal': (context) => const Journal(),
    },

    debugShowCheckedModeBanner: false,
    title: 'Lucas chatbot',
  ); //MaterialApp
 } //Widget build
} //MyApp class