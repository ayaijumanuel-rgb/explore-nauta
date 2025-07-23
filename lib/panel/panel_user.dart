import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:explore_nauta/app_drawer.dart';
import 'package:explore_nauta/panel/pages_incio/danza_cultural_page.dart';
import 'package:explore_nauta/panel/pages_incio/gastronomia_page.dart';
import 'package:explore_nauta/panel/pages_incio/hoteles_page.dart';
import 'package:explore_nauta/panel/pages_incio/lugares_turisticos_page.dart';

class PanelUserPage extends StatelessWidget {
   PanelUserPage({super.key});

  final List<_TourItem> items = [
    _TourItem(
      titulo: 'Lugares turisticos',
      imagenUrl: 'https://i.ibb.co/0Vjj6w4m/Laguna-Sapi-Sapi-vista-a-rea.jpg',
      page: LugaresTuristicosPage(),
    ),
    _TourItem(
      titulo: 'Gastronomía',
      imagenUrl: 'https://i.ibb.co/nq7TN4td/juane.jpg',
      page: GastronomiaPage(),
    ),
    _TourItem(
      titulo: 'Danza cultural',
      imagenUrl: 'https://i.ibb.co/YYGDJK2/NI-OS-KUKAMA-ANIVERSARIO-CILIAP.jpg',
      page: DanzaCulturalPage(),
    ),
    _TourItem(
      titulo: 'Hoteles',
      imagenUrl: 'https://i.ibb.co/YT7R7m1H/4d35ae60-z-1.png',
      page: HotelesPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF39A1A5),
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF39A1A5),
        elevation: 0,
        centerTitle: true,
        title: Text('INICIO'.tr(), style: const TextStyle(letterSpacing: 1)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 24),
        itemBuilder: (_, i) {
          final item = items[i];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => item.page),
            ),
            child: _LugarCard(item: item),
          );
        },
      ),
    );
  }
}

class _LugarCard extends StatelessWidget {
  final _TourItem item;
  const _LugarCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            item.imagenUrl,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            loadingBuilder: (_, child, progress) =>
                progress == null ? child : const LinearProgressIndicator(),
            errorBuilder: (_, __, ___) => Container(
              height: 180,
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const Icon(Icons.broken_image, size: 40),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          item.titulo.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _TourItem {
  final String titulo;
  final String imagenUrl;
  final Widget page;

  const _TourItem({
    required this.titulo,
    required this.imagenUrl,
    required this.page,
  });
}