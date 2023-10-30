import 'package:examen_machuca/auth/auth_controlador.dart';
import 'package:examen_machuca/screens/cambia_contrasena.dart';
import 'package:examen_machuca/screens/registro.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class LoginUsuario extends StatefulWidget {
  const LoginUsuario({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginUsuario> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de sesión'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300, //Ancho del campo
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: 300, //Ancho del campo
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Contraseña',
                  prefixIcon: Icon(Icons.key),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () async {
                final message = await AuthService().login(
                  email: _emailController.text,
                  password: _passwordController.text,
                );

                if (message == "Success") {
                  // Inicio de sesión exitoso, navegar a la página "home"
                  Get.offNamed("/home");
                } else {
                  // Mensaje de error
                  Get.snackbar("Error de inicio de sesión", message!,
                      snackPosition: SnackPosition.TOP);
                }
              },
              // ignore: sort_child_properties_last
              child: const Text('Iniciar sesión'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 184, 106, 248),
                padding: const EdgeInsets.all(16), // Espaciado interno
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                  side:
                      const BorderSide(color: Color.fromARGB(255, 70, 10, 138)),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  // Botón para ir a la página de registro de usuario
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistroUsuario(),
                      ),
                    );
                  },
                  child: const Text('Registrarse'),
                ),
                TextButton(
                  // Botón para recuperar la contraseña
                  onPressed: () async {
                    String email = _emailController.text;
                    if (email == "") {
                      Get.snackbar(
                        "Escriba su correo electrónico en la casilla de texto",
                        mensaje,
                        snackPosition: SnackPosition.TOP,
                      );
                    } else {
                      await recuperarContrasena(email);
                    }
                  },
                  child: const Text('Olvidé la contraseña'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
