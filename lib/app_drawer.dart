import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:explore_nauta/panel/opciones_menu/ajustes.dart';
// Asegúrate de importar PanelUserPage

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF39A1A5)),
            child: Center(
              child: Text(
                'MENÚ'.tr(),
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: Text('INICIO'.tr()), // Asegúrate de tener esta traducción
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/panel_user');
            },
          ),
          ListTile(
            leading: const Icon(Icons.restaurant),
            title: Text('RESTAURANTES'.tr()),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/restaurantes');
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_dining),
            title: Text('COMIDAS_Y_BEBIDAS'.tr()),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/comidas_bebidas');
            },
          ),
          ListTile(
            leading: const Icon(Icons.place),
            title: Text('SITIOS'.tr()),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sitios');
            },
          ),
          // Opción para ir al Panel de Usuario

          // Opción de Configuración
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text('CONFIGURACION'.tr()),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AjustesPage()),
              );
            },
          ),
          const Divider(),
          ExpansionTile(
            leading: const Icon(Icons.language),
            title: Text('CAMBIAR_IDIOMA'.tr()),
            children: [
              RadioListTile<Locale>(
                title: const Text('Español'),
                value: const Locale('es'),
                groupValue: currentLocale,
                onChanged: (locale) {
                  if (locale != null) {
                    context.setLocale(locale);
                    Navigator.pop(context);
                  }
                },
              ),
              RadioListTile<Locale>(
                title: const Text('English'),
                value: const Locale('en'),
                groupValue: currentLocale,
                onChanged: (locale) {
                  if (locale != null) {
                    context.setLocale(locale);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
