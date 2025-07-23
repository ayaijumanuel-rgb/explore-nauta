import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:explore_nauta/app_drawer.dart';

class SitiosPage extends StatelessWidget {
  const SitiosPage({super.key});

  final List<_TourItem> items = const [
    _TourItem(
      titulo: 'Iglesia Matriz (San Felipe y Santiago)',
      imagenUrl: 'https://i.ibb.co/G3bfDGN3/iglesia.jpg',
      descripcion:
          'Es la reserva natural más grande del Perú y una de las mayores áreas protegidas de la Amazonía.',
      direccionUrl: 'https://maps.app.goo.gl/uEraEzAH2WYiVeZM8',
    ),
    _TourItem(
      titulo: 'Plaza De Armas De Nauta',
      imagenUrl: 'https://i.ibb.co/1t6Rq6bG/15897135559-6402328c9d-b.jpg',
      descripcion:
          'Un parque nacional famoso por su gran biodiversidad y ecosistemas únicos.',
      direccionUrl: 'https://maps.app.goo.gl/xpKGhgNG2zeRTFin6',
    ),
    _TourItem(
      titulo: 'Plaza Francisco Bolognesi',
      imagenUrl: 'https://i.ibb.co/xtj4B1KL/IMG-20250619-WA0021.jpg',
      descripcion:
          'Un parque nacional famoso por su gran biodiversidad y ecosistemas únicos.',
      direccionUrl: 'https://maps.app.goo.gl/A8MQmGZpS2GiCTj8A',
    ),
    _TourItem(
      titulo: 'Plaza Miguel Grau Seminario',
      imagenUrl: 'https://i.ibb.co/RGYhhzgw/Captura-de-pantalla-2025-07-21-102519.png',
      descripcion:
          'Un parque atractivo para la ciudad de nauta ',
      direccionUrl: 'https://maps.app.goo.gl/b3K9qUmWu6g8JKTc8',
    ),
    _TourItem(
      titulo: 'TEATRO UCAMARA',
      imagenUrl: 'https://i.ibb.co/8DCGMdP7/ukamara.jpg',
      descripcion:
          'Un parque atractivo para la ciudad de nauta ',
      direccionUrl: 'https://maps.app.goo.gl/f8d4cMhPD5LTbd8L6',
    ),
  ];

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  void _mostrarDialogo(BuildContext context, _TourItem item) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  item.imagenUrl,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.titulo,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.descripcion,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.location_on),
                        label: const Text('Ver ubicación'),
                        onPressed: () => _launchUrl(item.direccionUrl),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF39A1A5),
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF39A1A5),
        elevation: 0,
        centerTitle: true,
        title: Text('SITIOS'.tr(), style: const TextStyle(letterSpacing: 1)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 24),
        itemBuilder: (_, i) => GestureDetector(
          onTap: () => _mostrarDialogo(context, items[i]),
          child: _LugarCard(item: items[i]),
        ),
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
  final String descripcion;
  final String direccionUrl;

  const _TourItem({
    required this.titulo,
    required this.imagenUrl,
    required this.descripcion,
    required this.direccionUrl,
  });
}