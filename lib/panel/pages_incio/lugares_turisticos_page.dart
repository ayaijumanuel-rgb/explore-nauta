import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class LugaresTuristicosPage extends StatelessWidget {
  final List<Map<String, String>> lugares = [
    {
      'nombre': 'Laguna Sapi Sapi',
      'imagen': 'https://i.ibb.co/0Vjj6w4m/Laguna-Sapi-Sapi-vista-a-rea.jpg',
      'descripcion': 'La laguna Sapi Sapi es un cuerpo de agua natural ubicada en la ciudad de Nauta, departamento de Loreto, Perú; se caracteriza por ser de aguas oscuras con animales exóticos (especies introducidas) contando con muchos atractivos entre los que se destacan la alimentación a diferentes variedades de especies acuáticas, alquiler de pequeños botes para tener una experiencia única. Se encuentra en el centro de la ciudad siendo una de las pocas que tiene una laguna natural en su área urbana en el Perú.',
      'ubicacion': 'https://maps.app.goo.gl/SP548YimPSUgfffm8',
    },
    {
      'nombre': 'Laguna Sapi Sapi',
      'imagen': 'https://i.ibb.co/0Vjj6w4m/Laguna-Sapi-Sapi-vista-a-rea.jpg',
      'descripcion': 'La laguna Sapi Sapi es un cuerpo de agua natural ubicada en la ciudad de Nauta, departamento de Loreto, Perú; se caracteriza por ser de aguas oscuras con animales exóticos (especies introducidas) contando con muchos atractivos entre los que se destacan la alimentación a diferentes variedades de especies acuáticas, alquiler de pequeños botes para tener una experiencia única. Se encuentra en el centro de la ciudad siendo una de las pocas que tiene una laguna natural en su área urbana en el Perú.',
      'ubicacion': 'https://maps.app.goo.gl/SP548YimPSUgfffm8',
    },
    {
      'nombre': 'Laguna Sapi Sapi',
      'imagen': 'https://i.ibb.co/0Vjj6w4m/Laguna-Sapi-Sapi-vista-a-rea.jpg',
      'descripcion': 'La laguna Sapi Sapi es un cuerpo de agua natural ubicada en la ciudad de Nauta, departamento de Loreto, Perú; se caracteriza por ser de aguas oscuras con animales exóticos (especies introducidas) contando con muchos atractivos entre los que se destacan la alimentación a diferentes variedades de especies acuáticas, alquiler de pequeños botes para tener una experiencia única. Se encuentra en el centro de la ciudad siendo una de las pocas que tiene una laguna natural en su área urbana en el Perú.',
      'ubicacion': 'https://maps.app.goo.gl/SP548YimPSUgfffm8',
    },
    {
      'nombre': 'Laguna Sapi Sapi',
      'imagen': 'https://i.ibb.co/0Vjj6w4m/Laguna-Sapi-Sapi-vista-a-rea.jpg',
      'descripcion': 'La laguna Sapi Sapi es un cuerpo de agua natural ubicada en la ciudad de Nauta, departamento de Loreto, Perú; se caracteriza por ser de aguas oscuras con animales exóticos (especies introducidas) contando con muchos atractivos entre los que se destacan la alimentación a diferentes variedades de especies acuáticas, alquiler de pequeños botes para tener una experiencia única. Se encuentra en el centro de la ciudad siendo una de las pocas que tiene una laguna natural en su área urbana en el Perú.',
      'ubicacion': 'https://maps.app.goo.gl/SP548YimPSUgfffm8',
    },
    // Agrega más lugares aquí
  ];

  void _abrirUbicacion(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir la ubicación.'.tr())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lugares turísticos'.tr()),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: lugares.length,
        itemBuilder: (context, index) {
          final lugar = lugares[index];
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
                    lugar['imagen']!,
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
                        lugar['nombre']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(lugar['descripcion']!),
                      const SizedBox(height: 15),
                      ElevatedButton.icon(
                        onPressed: () => _abrirUbicacion(context, lugar['ubicacion']!),
                        icon: const Icon(Icons.map),
                        label: Text('Ver en mapa'.tr()),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                      ),
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