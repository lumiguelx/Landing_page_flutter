import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'section_header.dart';

class ContatoSection extends StatelessWidget {
  const ContatoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryBlue, AppColors.secondaryBlue],
        ),
      ),
      child: Column(
        children: [
          const SectionHeader(
            title: 'Contato',
            subtitle: 'Entre em contato conosco',
            titleColor: AppColors.white,
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 700) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _buildContactInfo()),
                    const SizedBox(width: 40),
                    Expanded(flex: 3, child: _buildContactForm()),
                  ],
                );
              }
              return Column(
                children: [
                  _buildContactInfo(),
                  const SizedBox(height: 40),
                  _buildContactForm(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoItem(Icons.location_on, 'Endereço', 'Teixeira, PB'),
        const SizedBox(height: 20),
        _buildInfoItem(Icons.phone, 'Telefone', '(83) 9999-9999'),
        const SizedBox(height: 20),
        _buildInfoItem(Icons.email, 'Email', 'contato@superyama.com'),
        const SizedBox(height: 30),
        Row(
          children: [
            _buildSocialIcon(Icons.facebook),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.camera_alt), // Instagram
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.chat), // WhatsApp
          ],
        ),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.lightBlue, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 28),
          child: Text(
            value,
            style: TextStyle(
              color: AppColors.white.withValues(alpha: 0.8),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AppColors.white, size: 22),
    );
  }

  Widget _buildContactForm() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildTextField('Seu Nome')),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField('Seu Email')),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField('Sua Mensagem', maxLines: 4),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.redAccent,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: const Text(
            'Enviar Mensagem',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.white.withValues(alpha: 0.6)),
        filled: true,
        fillColor: AppColors.white.withValues(alpha: 0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.white.withValues(alpha: 0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.white.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.lightBlue, width: 2),
        ),
      ),
    );
  }
}
