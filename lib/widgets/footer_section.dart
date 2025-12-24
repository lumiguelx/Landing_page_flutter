import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      color: const Color(0xFF0F172A),
      child: Center(
        child: Text(
          '© 2025 Super Yama - Todos os direitos reservados',
          style: TextStyle(
            color: AppColors.white.withValues(alpha: 0.6),
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
