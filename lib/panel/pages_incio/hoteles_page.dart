import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelesPage extends StatelessWidget {
  final List<Map<String, String>> hoteles = [
    {
      'nombre': "Hospedaje 'La Granja Azul'",
      'imagen': 'https://i.ibb.co/vCPxpVVw/1.jpg',
      'descripcion': 'Hotel cómodo y accesible en el centro de Nauta, con habitaciones equipadas y servicio de calidad.',
      'ubicacion': 'https://maps.app.goo.gl/Bpv7Xa87my9yFRmW6',
      'telefono': '+51943450213',
    },
    {
      'nombre': 'Hospedaje Shelomit',
      'imagen': 'https://i.ibb.co/Q3zVRbbF/588793385.jpg',
      'descripcion': 'Hotel cómodo y accesible en el centro de Nauta, con habitaciones equipadas y servicio de calidad.',
      'ubicacion': 'https://maps.app.goo.gl/ZwkvEkNZDoxVAJzf7',
      'telefono': '+51987654321',
    },
    {
      'nombre': 'Hospedaje JAYKO',
      'imagen': 'https://i.ibb.co/zhv93mmz/1.jpg',
      'descripcion': 'Hotel cómodo y accesible en el centro de Nauta, con habitaciones equipadas y servicio de calidad.',
      'ubicacion': 'https://maps.app.goo.gl/WHhvvkkEJvgYGwK39',
      'telefono': '+51987654321',
    },
     {
      'nombre': 'Hotel Ribera II',
      'imagen': 'https://i.ibb.co/qL2QJpkw/Screenshot-20250601-224548-Google.jpg',
      'descripcion': 'Hotel cómodo y accesible en el centro de Nauta, con habitaciones equipadas y servicio de calidad.',
      'ubicacion': 'https://maps.app.goo.gl/VDtyZtvraabqKrtD7',
      'telefono': '+51987654321',
    },
    {
      'nombre': 'Hospedaje Plaza Inn',
      'imagen': 'https://i.ibb.co/0pnzZDND/Screenshot-20250601-190052-Google.jpg',
      'descripcion': 'Hotel cómodo y accesible en el centro de Nauta, con habitaciones equipadas y servicio de calidad.',
      'ubicacion': 'https://maps.app.goo.gl/L6YVxcQpebquCkio6',
      'telefono': '+51987654321',
    },
    // Agrega más hoteles aquí
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

  void _llamarTelefono(BuildContext context, String telefono) async {
    final uri = Uri.parse('tel:$telefono');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo realizar la llamada.'.tr())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hoteles'.tr()),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: hoteles.length,
        itemBuilder: (context, index) {
          final hotel = hoteles[index];
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
                    hotel['imagen']!,
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
                        hotel['nombre']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(hotel['descripcion']!),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _abrirUbicacion(context, hotel['ubicacion']!),
                              icon: const Icon(Icons.map),
                              label: Text('Ubicación'.tr()),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _llamarTelefono(context, hotel['telefono']!),
                              icon: const Icon(Icons.phone),
                              label: Text('Llamar'.tr()),
                            ),
                          ),
                        ],
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
