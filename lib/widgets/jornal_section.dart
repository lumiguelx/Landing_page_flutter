import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'section_header.dart';

class JornalSection extends StatelessWidget {
  const JornalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: AppColors.white,
      child: Column(
        children: [
          const SectionHeader(
            title: 'Jornal da Semana',
            subtitle: 'Confira as ofertas e promoções da semana',
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildJornalCard('Frente', AppColors.lightBlue),
                    const SizedBox(width: 24),
                    _buildJornalCard('Verso', AppColors.secondaryBlue.withValues(alpha: 0.3)),
                  ],
                );
              }
              return Column(
                children: [
                  _buildJornalCard('Frente', AppColors.lightBlue),
                  const SizedBox(height: 24),
                  _buildJornalCard('Verso', AppColors.secondaryBlue.withValues(alpha: 0.3)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildJornalCard(String label, Color bgColor) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.primaryBlue,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.redAccent,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Clique para ver'),
          ),
        ],
      ),
    );
  }
}
