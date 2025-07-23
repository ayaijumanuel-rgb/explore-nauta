import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:explore_nauta/app_drawer.dart';

class RestaurantesPage extends StatelessWidget {
  const RestaurantesPage({super.key});

  final List<_LugarItem> items = const [
    _LugarItem(
      titulo: 'Restaurante Pikatsso',
      imagenUrl: 'https://i.ibb.co/nqL3qQg9/IMG-20250619-WA0020.jpg',
      telefono: '+51912345678',
      whatsapp: '+51912345678',
      ubicacionUrl: 'https://maps.app.goo.gl/pxDoEgnkW5HGmj8b6',
    ),
    _LugarItem(
      titulo: 'Restaurant Maricielo',
      imagenUrl: 'https://i.ibb.co/TxX066J2/IMG-20250619-WA0041.jpg',
      telefono: '+51987654321',
      whatsapp: '+51987654321',
      ubicacionUrl: 'https://maps.app.goo.gl/CZ3SQm9NTfTPFiEr7',
    ),

        _LugarItem(
      titulo: 'Zwei - Nauta Tours',
      imagenUrl: 'https://i.ibb.co/qM2BV2v0/IMG-20250619-WA0036.jpg',
      telefono: '+51987654321',
      whatsapp: '+51987654321',
      ubicacionUrl: 'https://maps.app.goo.gl/jrZjCdx8nHqYunRBA',
    ),
      _LugarItem(
      titulo: 'Polleria Jhimys',
      imagenUrl: 'https://i.ibb.co/FqDbDp66/unnamed-1.jpg',
      telefono: '+51987654321',
      whatsapp: '+51987654321',
      ubicacionUrl: 'https://maps.app.goo.gl/X9z4cRqncUnHCvdTA',
    ),
  ];

  void _mostrarDialogo(BuildContext context, _LugarItem item) {
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
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          tooltip: 'Llamar'.tr(),
                          icon: const Icon(Icons.call, color: Colors.green),
                          onPressed: () async {
                            final Uri callUri = Uri(scheme: 'tel', path: item.telefono);
                            if (await canLaunchUrl(callUri)) {
                              await launchUrl(callUri);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('No se pudo realizar la llamada.'.tr())),
                              );
                            }
                          },
                        ),
                        IconButton(
                          tooltip: 'WhatsApp'.tr(),
                          icon: const Icon(Icons.chat, color: Colors.green),
                          onPressed: () async {
                            final whatsappUrl = Uri.parse(
                                'https://wa.me/${item.whatsapp.replaceAll('+', '')}');
                            if (await canLaunchUrl(whatsappUrl)) {
                              await launchUrl(whatsappUrl,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('No se pudo abrir WhatsApp.'.tr())),
                              );
                            }
                          },
                        ),
                        IconButton(
                          tooltip: 'Ver mapa'.tr(),
                          icon: const Icon(Icons.map, color: Colors.blue),
                          onPressed: () async {
                            final Uri mapUri = Uri.parse(item.ubicacionUrl);
                            if (await canLaunchUrl(mapUri)) {
                              await launchUrl(mapUri, mode: LaunchMode.externalApplication);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('No se pudo abrir el mapa.'.tr())),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
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
        title: Text('RESTAURANTES'.tr(), style: const TextStyle(letterSpacing: 1)),
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
  final _LugarItem item;
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

class _LugarItem {
  final String titulo;
  final String imagenUrl;
  final String telefono;
  final String whatsapp;
  final String ubicacionUrl;

  const _LugarItem({
    required this.titulo,
    required this.imagenUrl,
    required this.telefono,
    required this.whatsapp,
    required this.ubicacionUrl,
  });
}
