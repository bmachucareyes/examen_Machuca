import 'package:examen_machuca/screens/categorias.dart';
import 'package:examen_machuca/screens/home.dart';
import 'package:examen_machuca/screens/login.dart';
import 'package:examen_machuca/screens/productos.dart';
import 'package:examen_machuca/screens/proveedores.dart';
import 'package:examen_machuca/screens/registro.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

var pages = [
  GetPage(
    // Login
    name: "/login",
    page: () => const LoginUsuario(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    // Registro de usuario
    name: "/signup",
    page: () => const RegistroUsuario(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    // Home
    name: "/home",
    page: () => const Home(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    // Proveedores
    name: "/proveedores",
    page: () => const ProveedoresScreen(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    // Categoríass
    name: "/categorias",
    page: () => const CategoriasScreen(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    // Productos
    name: "/productos",
    page: () => const ProductosScreen(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 500),
  ),
];
