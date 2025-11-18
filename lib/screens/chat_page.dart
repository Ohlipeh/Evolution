import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        title: const Text("Chat", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryDark,
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Tela de Chat",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}
