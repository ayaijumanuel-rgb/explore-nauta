import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Si usas Firebase
import 'package:explore_nauta/app_drawer.dart';

class AjustesPage extends StatefulWidget {
  const AjustesPage({super.key});

  @override
  State<AjustesPage> createState() => _AjustesPageState();
}

class _AjustesPageState extends State<AjustesPage> {
  bool _notificacionesActivas = true;
  bool _modoOscuro = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF39A1A5),
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF39A1A5),
        elevation: 0,
        centerTitle: true,
        title: Text('CONFIGURACION'.tr(), 
               style: const TextStyle(letterSpacing: 1)),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildSettingItem(
              icon: Icons.notifications,
              title: 'NOTIFICACIONES'.tr(),
              trailing: Switch(
                value: _notificacionesActivas,
                onChanged: (value) {
                  setState(() {
                    _notificacionesActivas = value;
                  });
                },
                activeColor: const Color(0xFF39A1A5),
              ),
            ),
            _buildSettingItem(
              icon: Icons.dark_mode,
              title: 'MODO_OSCURO'.tr(),
              trailing: Switch(
                value: _modoOscuro,
                onChanged: (value) {
                  setState(() {
                    _modoOscuro = value;
                  });
                },
                activeColor: const Color(0xFF39A1A5),
              ),
            ),
            _buildSettingItem(
              icon: Icons.privacy_tip,
              title: 'POLITICA_PRIVACIDAD'.tr(),
              onTap: () {
                // Navegar a política de privacidad
              },
            ),
            _buildSettingItem(
              icon: Icons.help,
              title: 'AYUDA_SOPORTE'.tr(),
              onTap: () {
                // Navegar a ayuda
              },
            ),
            _buildSettingItem(
              icon: Icons.info,
              title: 'ACERCA_DE'.tr(),
              onTap: () {
                // Navegar a acerca de
              },
            ),
            const SizedBox(height: 30),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF39A1A5)),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red[400],
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () => _confirmLogout(context),
      icon: const Icon(Icons.logout, color: Colors.white),
      label: Text(
        'CERRAR_SESION'.tr(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('CERRAR_SESION'.tr()),
          content: Text('CONFIRM_LOGOUT'.tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('CANCELAR'.tr()),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await _performLogout(context);
              },
              child: Text('ACEPTAR'.tr(), 
                     style: const TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _performLogout(BuildContext context) async {
    try {
      // 1. Cerrar sesión en Firebase (si lo usas)
      await FirebaseAuth.instance.signOut();
      
      // 2. Limpiar datos locales
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      
      // 3. Redirigir a pantalla de login
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context, 
        '/login', 
        (Route<dynamic> route) => false
      );
      
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('LOGOUT_ERROR'.tr())),
      );
    }
  }
}