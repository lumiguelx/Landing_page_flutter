import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/hero_section.dart';
import '../widgets/jornal_section.dart';
import '../widgets/delivery_section.dart';
import '../widgets/galeria_section.dart';
import '../widgets/sugestoes_section.dart';
import '../widgets/localizacao_section.dart';
import '../widgets/contato_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/zoomable_image_demo.dart';
import '../widgets/pixel_grid_demo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _jornalKey = GlobalKey();
  final GlobalKey _deliveryKey = GlobalKey();
  final GlobalKey _galeriaKey = GlobalKey();
  final GlobalKey _sugestoesKey = GlobalKey();
  final GlobalKey _localizacaoKey = GlobalKey();
  final GlobalKey _contatoKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
    Navigator.pop(this.context); // Fecha o drawer se estiver aberto
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text(
          'Super Yama',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HeroSection(key: _heroKey),
            JornalSection(key: _jornalKey),
            DeliverySection(key: _deliveryKey),
            GaleriaSection(key: _galeriaKey),
            SugestoesSection(key: _sugestoesKey),
            LocalizacaoSection(key: _localizacaoKey),
            ContatoSection(key: _contatoKey),
            const FooterSection(),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PixelGridDemo(),
                ),
              );
            },
            backgroundColor: AppColors.secondaryBlue,
            foregroundColor: AppColors.white,
            tooltip: 'Demo: Pixel Grid',
            heroTag: "pixel_grid_fab",
            child: const Icon(Icons.grid_on),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ZoomableImageDemo(),
                ),
              );
            },
            backgroundColor: AppColors.redAccent,
            foregroundColor: AppColors.white,
            tooltip: 'Demo: Imagens com Zoom',
            heroTag: "zoom_fab",
            child: const Icon(Icons.zoom_in),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.primaryBlue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Super Yama',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Supermercado',
                  style: TextStyle(color: AppColors.lightBlue, fontSize: 16),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.home, 'Início', _heroKey),
          _buildDrawerItem(Icons.newspaper, 'Jornal', _jornalKey),
          _buildDrawerItem(Icons.delivery_dining, 'Delivery', _deliveryKey),
          _buildDrawerItem(Icons.photo_library, 'Galeria', _galeriaKey),
          _buildDrawerItem(Icons.lightbulb, 'Sugestões', _sugestoesKey),
          _buildDrawerItem(Icons.location_on, 'Localização', _localizacaoKey),
          _buildDrawerItem(Icons.contact_mail, 'Contato', _contatoKey),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.zoom_in, color: AppColors.redAccent),
            title: const Text('Demo: Imagens Zoom'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ZoomableImageDemo(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.grid_on, color: AppColors.secondaryBlue),
            title: const Text('Demo: Pixel Grid'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PixelGridDemo(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, GlobalKey key) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryBlue),
      title: Text(title),
      onTap: () => _scrollToSection(key),
    );
  }
}
