import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

const mensaje = "";
// ignore: camel_case_types
Future<void> recuperarContrasena(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    // El correo de restablecimiento de contraseña se ha enviado con éxito. Favor revisa tu casilla de correo.
    Get.snackbar("Correo de recuperación de contraseña enviado", mensaje,
        snackPosition: SnackPosition.TOP);
  } catch (e) {
    // Ocurrió un error al enviar el correo de restablecimiento de contraseña.
    if (kDebugMode) {
      print(e.toString());
    }
  }
}
