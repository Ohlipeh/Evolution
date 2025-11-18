import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final Color primaryDark;
  final Color secondaryPurple;
  final Color secondaryPink;

  const AppDrawer({
    super.key,
    required this.primaryDark,
    required this.secondaryPurple,
    required this.secondaryPink,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryDark,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [secondaryPurple, secondaryPink],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Evolution XP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Bem-vindo(a)!',
                  style: TextStyle(color: Colors.white70),
                )
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text('Início', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pop(context),
          ),

          ListTile(
            leading: const Icon(Icons.trending_up, color: Colors.white),
            title: const Text('Progresso', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text('Perfil', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),

          const Divider(color: Colors.white24),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title:
            const Text('Sair', style: TextStyle(color: Colors.redAccent)),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
