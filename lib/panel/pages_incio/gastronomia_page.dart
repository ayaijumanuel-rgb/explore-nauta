import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class GastronomiaPage extends StatelessWidget {
  final List<Map<String, String>> platos = [
    {
      'nombre': 'Juane',
      'imagen': 'https://i.ibb.co/nq7TN4td/juane.jpg',
      'descripcion': 'Plato típico de la Amazonía peruana preparado con arroz, carne de gallina, huevos y especias, todo envuelto en hojas de bijao.',
    },
    {
      'nombre': 'Juane',
      'imagen': 'https://i.ibb.co/nq7TN4td/juane.jpg',
      'descripcion': 'Plato típico de la Amazonía peruana preparado con arroz, carne de gallina, huevos y especias, todo envuelto en hojas de bijao.',
    },
    // Agrega más platos aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gastronomía'.tr()),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: platos.length,
        itemBuilder: (context, index) {
          final plato = platos[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: Image.network(
                    plato['imagen']!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plato['nombre']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(plato['descripcion']!),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}