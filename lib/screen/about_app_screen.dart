import 'package:flutter/material.dart';
import '../color_scheme.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorScheme.bg,
      appBar: AppBar(
        backgroundColor: AppColorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'About Herzpunkt',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container( //Logo ng app
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

            const SizedBox(height: 16),

            // App Name
            const Text(
              'Herzpunkt',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 32),

            // Info Cards
            _buildCard(
              icon: Icons.info_outline,
              title: 'What is Herzpunkt?',
              description:
                  'Herzpunkt is a daily check in app designed to help you manage your mood and improve your overall well-being.',
            ),

            const SizedBox(height: 16),

            _buildCard(
              icon: Icons.chat,
              title: 'Who is Lucas?',
              description:
                  'Lucas is your personal chatbot designed to help your mental care.',
            ),

            const SizedBox(height: 16),

            _buildCard(
              icon: Icons.group_outlined,
              title: 'Our Team',
              description:
                  'Built with care by a passionate team dedicated to making mentalcare accessible and easy to use.\nBryan Sese\nJonel Lucas\nJester Rubia\nJenna Palisoc',
            ),          

            const SizedBox(height: 16),

            _buildCard(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy',
              description:
                  'Your data is safe with us. We do not share your personal information with third parties.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColorScheme.elevated,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColorScheme.accentRim, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFFD6D3E0),
                    fontSize: 13,
                    height: 1.5,
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