import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Exemplo de valores — depois você pode conectar ao banco
    final String usuario = "Usuário 2311";
    final int level = 300;
    final int xpAtual = 74;
    final int xpMax = 100;
    final int xpTotal = 289999;

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// Nome do usuário
            Text(
              usuario,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            /// Avatar com badge lateral
            Stack(
              clipBehavior: Clip.none,
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),

                /// Badge roxa com o level pequeno
                Positioned(
                  right: -6,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.secondaryPurple,
                          AppColors.secondaryPink
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      level.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            /// Level principal
            Text(
              "LEVEL $level",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            /// Barra de XP com gradiente
            Container(
              width: 280,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.white30, width: 2),
              ),
              child: Stack(
                children: [
                  // Barra preenchida
                  Container(
                    width: 280 * (xpAtual / xpMax),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.secondaryPurple,
                          AppColors.secondaryPink
                        ],
                      ),
                    ),
                  ),

                  // Texto central
                  Center(
                    child: Text(
                      "$xpAtual/$xpMax",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// XP total
            Text(
              "$xpTotal XP Total",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 50),

            /// Botão Excluir Conta
            GestureDetector(
              onTap: () {}, // depois você implementa a função
              child: const Text(
                "Excluir Conta",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 17,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),

            const SizedBox(height: 60),

            /// Rodapé
            const Text(
              "APK DESENVOLVIDO POR: DART LABS",
              style: TextStyle(
                color: Colors.white38,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
