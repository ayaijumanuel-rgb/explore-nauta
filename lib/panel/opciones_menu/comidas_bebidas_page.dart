import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:explore_nauta/app_drawer.dart';

class ComidasBebidasPage extends StatelessWidget {
  const ComidasBebidasPage({super.key});

  final List<_TourItem> items = const [
    _TourItem(
      titulo: 'Juane',
      imagenUrl: 'https://i.ibb.co/DPzc6hcB/juane.jpg',
      descripcion: 'Delicioso plato típico amazónico hecho con arroz, especias y envuelto en hojas de bijao.',
    ),
    _TourItem(
      titulo: 'Zarapatera',
      imagenUrl: 'https://i.ibb.co/C3j0vQ3D/3.jpg',
      descripcion: 'Se cocina en el caparazon de la tortuga, muy popular en la región.',
    ),
    _TourItem(
      titulo: 'Aguajina',
      imagenUrl: 'https://i.ibb.co/1ffb1px4/aguaje.jpg',
      descripcion: 'Bebida refrescante hecha con el fruto amazónico aguaje, rico en vitaminas.',
    ),
    _TourItem(
      titulo: 'Patarashca',
      imagenUrl: 'https://i.ibb.co/23W3ZZW4/2.jpg',
      descripcion: 'Pescado envuelto en hoja de bijao , y especias típicas de la Amazonía.',
    ),
    _TourItem(
      titulo: 'Chicha Morada',
      imagenUrl: 'https://i.ibb.co/PzQGK3Bt/chicha-morada.jpg',
      descripcion: 'Pescado envuelto en hoja de bijao , y especias típicas de la Amazonía.',
    ),
    _TourItem(
      titulo: 'Refresco de camu camu',
      imagenUrl: 'https://i.ibb.co/1trNbyBm/camu-camu.jpg',
      descripcion: 'Pescado envuelto en hoja de bijao , y especias típicas de la Amazonía.',
    ),
  ];

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
        title: Text('COMIDAS_Y_BEBIDAS'.tr(), style: const TextStyle(letterSpacing: 1)),
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

  const _TourItem({
    required this.titulo,
    required this.imagenUrl,
    required this.descripcion,
  });
}
