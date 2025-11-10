import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evolution - Login'),
        backgroundColor: Colors.blueGrey,
      ),
      body: const Center(
        child: Text('Página de Login (a ser implementada)', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}