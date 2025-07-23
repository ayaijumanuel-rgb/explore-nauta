import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'register.dart';
import '../panel/panel_user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;

  // ───────────────────── LOGIN CON EMAIL ─────────────────────
  Future<void> _loginWithEmail() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );
      if (!mounted) return;
      setState(() => _isLoading = false);
      _goToPanel();
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        _showSnack(_firebaseErrorToText(e.code), isError: true);
        setState(() => _isLoading = false);
      }
    }
  }

  // ───────────────────── LOGIN CON GOOGLE ────────────────────
  Future<void> _loginWithGoogle() async {
    setState(() => _isLoading = true);

    try {
      final googleSignIn = GoogleSignIn(scopes: ['email']);
      await googleSignIn.signOut(); // Fuerza selector de cuenta

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        if (mounted) setState(() => _isLoading = false);
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCred = await FirebaseAuth.instance.signInWithCredential(credential);
      await _createUserDocIfNeeded(userCred.user);

      if (!mounted) return;
      setState(() => _isLoading = false);
      _goToPanel();
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        _showSnack(_firebaseErrorToText(e.code), isError: true);
        setState(() => _isLoading = false);
      }
    } catch (_) {
      if (mounted) {
        _showSnack('unknown_error'.tr(), isError: true);
        setState(() => _isLoading = false);
      }
    }
  }

  // ─────────── CREA/ACTUALIZA DOCUMENTO EN FIRESTORE ────────────
  Future<void> _createUserDocIfNeeded(
    User? user, {
    Map<String, dynamic>? additionalData,
  }) async {
    if (user == null) return;

    final userData = {
      'name': user.displayName ?? '',
      'lastname': '',
      'email': user.email ?? '',
      'phone': '',
      'language': context.locale.languageCode,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      if (additionalData != null) ...additionalData,
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(userData, SetOptions(merge: true));
  }

  // ────────────────────────── RECUPERAR CONTRASEÑA ──────────────────────────
  Future<void> _mostrarDialogoRecuperarContrasena() async {
    final TextEditingController emailController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('recover_password'.tr()),
          content: TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'email'.tr(),
              hintText: 'enter_email'.tr(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('cancel'.tr()),
            ),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text.trim();
                if (email.isEmpty || !email.contains('@')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('invalid_email'.tr()),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('reset_email_sent'.tr()),
                      backgroundColor: Colors.green,
                    ),
                  );
                } on FirebaseAuthException catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${'error'.tr()}: ${e.message}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('send'.tr()),
            ),
          ],
        );
      },
    );
  }

  // ────────────────────────── UTILS ──────────────────────────
  void _goToPanel() => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  PanelUserPage()),
      );

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
    ));
  }

  String _firebaseErrorToText(String code) {
    switch (code) {
      case 'user-not-found':
        return 'user_not_found'.tr();
      case 'wrong-password':
        return 'wrong_password'.tr();
      case 'invalid-email':
        return 'invalid_email'.tr();
      default:
        return 'unknown_error'.tr();
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  // ─────────────────────────── UI ────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'.tr()),
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            onSelected: (locale) async {
              await context.setLocale(locale);
              setState(() {});
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: const Locale('en'),
                child: Text(
                  'English',
                  style: TextStyle(
                    color: context.locale == const Locale('en')
                        ? Theme.of(context).primaryColor
                        : null,
                  ),
                ),
              ),
              PopupMenuItem(
                value: const Locale('es'),
                child: Text(
                  'Español',
                  style: TextStyle(
                    color: context.locale == const Locale('es')
                        ? Theme.of(context).primaryColor
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    FlutterLogo(size: 120),
                    const SizedBox(height: 40),

                    // Email
                    TextFormField(
                      controller: _email,
                      decoration: InputDecoration(
                        labelText: 'email'.tr(),
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) =>
                          v?.contains('@') ?? false ? null : 'invalid_email'.tr(),
                    ),
                    const SizedBox(height: 20),

                    // Password
                    TextFormField(
                      controller: _password,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'password'.tr(),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () => setState(() => _obscureText = !_obscureText),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (v) =>
                          v?.isNotEmpty ?? false ? null : 'field_required'.tr(),
                    ),
                    const SizedBox(height: 10),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _mostrarDialogoRecuperarContrasena,
                        child: Text('forgot_password'.tr()),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Login Button
                    ElevatedButton(
                      onPressed: _loginWithEmail,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('enter'.tr()),
                    ),
                    const SizedBox(height: 20),

                    // Divider
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'or'.tr(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Google Login
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _loginWithGoogle,
                      icon: const FaIcon(FontAwesomeIcons.google, size: 18),
                      label: Text('continue_google'.tr()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.redAccent),
                        ),
                        elevation: 1,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Register Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('no_account'.tr()),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const RegisterPage()),
                          ),
                          child: Text('register'.tr()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
