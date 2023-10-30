import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menú principal"),
      ),
      body: const Center(
        child: MenuVertical(),
      ),
    );
  }
}

class MenuVertical extends StatelessWidget {
  const MenuVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MenuOption(
            title: "Proveedores",
            icon: Icons.store_rounded,
            color: Color.fromARGB(255, 33, 176, 223),
            routeName: '/proveedores',
          ),
          MenuOption(
            title: "Categorías",
            icon: Icons.category_rounded,
            color: Color.fromARGB(255, 205, 92, 240),
            routeName: '/categorias',
          ),
          MenuOption(
            title: "Productos",
            icon: Icons.production_quantity_limits_outlined,
            color: Color.fromARGB(255, 38, 172, 152),
            routeName: '/productos',
          ),
        ],
      ),
    );
  }
}

class MenuOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String routeName;

  const MenuOption(
      {super.key,
      required this.title,
      required this.icon,
      required this.color,
      required this.routeName});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, routeName);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        minimumSize: const Size(
            double.infinity, 100), // Ajusta el ancho al de la pantalla
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 24.0,
          ),
          const SizedBox(width: 16.0),
          Text(
            title,
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
