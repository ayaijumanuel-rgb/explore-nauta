import 'package:explore_nauta/panel/opciones_menu/comidas_bebidas_page.dart';
import 'package:explore_nauta/panel/opciones_menu/restaurantes_page.dart';
import 'package:explore_nauta/panel/opciones_menu/sitios_page.dart';
import 'package:explore_nauta/panel/panel_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Para kIsWeb
import 'package:easy_localization/easy_localization.dart';
import 'package:explore_nauta/user/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';



// Clave global de navegación
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Inicializa localización antes que nada
  await EasyLocalization.ensureInitialized();

  try {
    // 2. Inicializa Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // 3. Facebook SDK solo para Web
    if (kIsWeb) {
      await FacebookAuth.instance.webAndDesktopInitialize(
        appId: "3020455181589285",
        cookie: true,
        xfbml: true,
        version: "v18.0",
      );
    }

    // 4. Ejecuta app con localización
    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('es')],
        path: 'assets/translations',
        fallbackLocale: const Locale('es'),
        child: const MyApp(),
      ),
    );
  } catch (e, stackTrace) {
    debugPrint('Error inicializando: $e');
    debugPrint('Stack trace: $stackTrace');

    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Error inicializando la app:\n${e.toString()}'),
        ),
      ),
    ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explore Nauta',
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      // Usamos rutas para manejar navegación
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginPage(),
        '/panel_user': (_) => PanelUserPage(),
        '/restaurantes': (_) => const RestaurantesPage(),
        '/comidas_bebidas': (_) => const ComidasBebidasPage(),
        '/sitios': (_) => const SitiosPage(),
      },
    );
  }
}
