import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lucaschatbot/screen/ChatbotScreen.dart';
import 'package:lucaschatbot/screen/homepage.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

  class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin{

    Timer? _timer;
    late AnimationController _controller;
    late Animation<double> _fadeAnimation;
    late Animation<double> _scaleAnimation;

    @override 
    void initState(){
      super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
      );

      _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeIn),
        );

      _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
        );

        _controller.forward();
    
      _timer = Timer(const Duration(seconds: 3), (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatBotScreen()),
          );
      });
    }

    @override
      void dispose() {
        _controller.dispose();
        _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFF3C3489),
      body: Center(
        child: FadeTransition(opacity: _fadeAnimation,
        child: ScaleTransition(scale: _scaleAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: Color(0x26FFFFFF),
                shape: BoxShape.circle,
              ),
              child:  const Icon(
                Icons.favorite,
                color: Colors.white,
                size: 60,
                  ),
                ),
            const SizedBox(height: 20),
            const Text(
              'Lucas Chatbot',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}