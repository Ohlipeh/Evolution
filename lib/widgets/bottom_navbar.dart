import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final Color secondaryPurple;
  final Color secondaryPink;
  final Color primaryDark;

  // Novo Callback para o botão central FAB (Adicionar Hábito)
  final VoidCallback onAddPressed;

  const BottomNavBar({
    super.key,
    required this.secondaryPurple,
    required this.secondaryPink,
    required this.primaryDark,
    // Adicionado o callback obrigatório
    required this.onAddPressed,
  });

  /// Função utilitária para navegação de abas (limpa a pilha)
  void _navigate(BuildContext context, String route) {
    // Se a rota atual não for a desejada, navega
    if (ModalRoute.of(context)?.settings.name != route) {
      // Usamos pushReplacementNamed para substituir a tela e limpar a pilha
      Navigator.pushReplacementNamed(context, route);
    }
  }

  /// Constrói um item clicável da barra de navegação
  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String route,
    required bool isSelected,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _navigate(context, route),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Icon(
              icon,
              size: 30,
              // Ícone da página atual é branco, outros são cinza/inativos
              color: isSelected ? Colors.white : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // O nome da rota atual é necessário para saber qual ícone destacar
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '/home';

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
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // HOME
          _buildNavItem(
            context: context,
            icon: Icons.home,
            route: '/home',
            isSelected: currentRoute == '/home',
          ),

          // PROGRESSO
          _buildNavItem(
            context: context,
            icon: Icons.trending_up,
            route: '/progresso',
            isSelected: currentRoute == '/progresso',
          ),

          // Espaço para o FAB (Floating Action Button)
          SizedBox(width: 40),

          // MOTIVAÇÃO (Chat)
          _buildNavItem(
            context: context,
            icon: Icons.chat_bubble_outline,
            route: '/motivation', // Assumindo que você usará /motivation para a tela de frase IA
            isSelected: currentRoute == '/motivation',
          ),

          // PERFIL
          _buildNavItem(
            context: context,
            icon: Icons.person_outline,
            route: '/perfil',
            isSelected: currentRoute == '/perfil',
          ),
        ],
      ),
    );
  }
}