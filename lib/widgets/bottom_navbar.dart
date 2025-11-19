import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final Color secondaryPurple;
  final Color secondaryPink;
  final Color primaryDark;

  const BottomNavBar({
    super.key,
    required this.secondaryPurple,
    required this.secondaryPink,
    required this.primaryDark,
  });

  /// Função de navegação que substitui a tela atual para não empilhar infinitamente
  void _navigate(BuildContext context, String route) {
    // Verifica se já não estamos na tela que queremos ir
    if (ModalRoute.of(context)?.settings.name != route) {
      Navigator.pushReplacementNamed(context, route);
    }
  }

  /// Constrói cada ícone da barra
  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String route,
  }) {
    // Verifica se esta é a rota ativa para destacar o ícone em branco
    final bool isSelected = ModalRoute.of(context)?.settings.name == route;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _navigate(context, route),
          borderRadius: BorderRadius.circular(40), // Feedback de toque redondo
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0), // Aumenta a área de toque
            child: Icon(
              icon,
              size: 30,
              color: isSelected ? Colors.white : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [secondaryPurple, secondaryPink],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: secondaryPink.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Botão HOME
          _buildNavItem(context: context, icon: Icons.home, route: '/home'),

          // Botão PROGRESSO (Gráfico)
          _buildNavItem(context: context, icon: Icons.trending_up, route: '/progresso'),

          // Espaço vazio no meio para o botão flutuante (+)
          const SizedBox(width: 50),

          // Botão MOTIVAÇÃO (Chat/Frase)
          _buildNavItem(context: context, icon: Icons.chat_bubble_outline, route: '/motivation'),

          // Botão PERFIL
          _buildNavItem(context: context, icon: Icons.person_outline, route: '/perfil'),
        ],
      ),
    );
  }
}