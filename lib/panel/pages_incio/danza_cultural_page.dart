import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class DanzaCulturalPage extends StatelessWidget {
  final List<Map<String, String>> danzas = [
    {
      'nombre': 'Danza Kukama',
      'imagen': 'https://i.ibb.co/YYGDJK2/NI-OS-KUKAMA-ANIVERSARIO-CILIAP.jpg',
      'descripcion': 'La danza Kukama es una expresión cultural de la etnia del mismo nombre que habita en la región de Loreto. Representa tradiciones, mitos y costumbres de esta comunidad indígena.',
    },
    // Agrega más danzas aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danzas culturales'.tr()),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: danzas.length,
        itemBuilder: (context, index) {
          final danza = danzas[index];
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
                    danza['imagen']!,
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
                        danza['nombre']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(danza['descripcion']!),
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