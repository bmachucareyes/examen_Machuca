import 'package:examen_machuca/auth/auth_controlador.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class RegistroUsuario extends StatefulWidget {
  const RegistroUsuario({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<RegistroUsuario> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de nuevo usuario'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: 300,
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
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () async {
                final message = await AuthService().registration(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
                if (message == "Success") {
                  // Inicio de sesión exitoso, navegar a la página "home"
                  Get.offNamed("/home");
                } else {
                  // Mensaje de error
                  Get.snackbar("Error de inicio de sesión", message!,
                      snackPosition: SnackPosition.BOTTOM);
                }
              },
              // ignore: sort_child_properties_last
              child: const Text('Registarse'),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(120, 50),
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 180, 144, 209),
                padding: const EdgeInsets.all(16), // Espaciado interno
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                  side:
                      const BorderSide(color: Color.fromARGB(255, 70, 10, 138)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
