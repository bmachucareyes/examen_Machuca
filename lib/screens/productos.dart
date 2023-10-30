import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examen_machuca/services/productos_services.dart';
import 'package:flutter/material.dart';

class Productos {
  final String id;
  final String nombre;
  final String categoria;
  final String proveedor;
  final String valor;

  Productos({
    required this.id,
    required this.nombre,
    required this.categoria,
    required this.proveedor,
    required this.valor,
  });
}

class ProductosScreen extends StatelessWidget {
  const ProductosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de productos'),
      ),
      body: const ProductosList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navega a la pantalla de agregar un nuevo producto.
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AgregarProductosScreen()));
        },
        backgroundColor: const Color.fromARGB(255, 54, 244, 111),
        child: const Icon(Icons.production_quantity_limits_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class ProductosList extends StatelessWidget {
  const ProductosList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('productos').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var producto = snapshot.data?.docs[index];
              var data = producto?.data() as Map<String, dynamic>;
              var id = producto?.id;

              return ListTile(
                title: Text("Nombre: ${data['nombre']}"),
                subtitle: Text("Valor: ${data['valor']}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_sharp),
                      color: const Color.fromARGB(255, 29, 98, 167),
                      onPressed: () {
                        // Obtiene los valores del producto seleccionado
                        String productoId = producto!.id;
                        String nombreActual = data['nombre'];
                        String categoriaActual = data['categoria'];
                        String proveedorActual = data['empresa'];
                        String valorActual = data['valor'];

                        // Navega a la pantalla de edición con los datos actuales del producto.
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditarProducto(
                              productoId: productoId,
                              nombreActual: nombreActual,
                              categoriaActual: categoriaActual,
                              proveedorActual: proveedorActual,
                              valorActual: valorActual,
                              nombre: null,
                              categoria: null,
                              proveedor: null,
                              valor: null,
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: const Color.fromARGB(255, 238, 43, 43),
                      onPressed: () {
                        // Elimina el proveedor al presionar el icono del basurero.
                        FirebaseFirestore.instance
                            .collection('productos')
                            .doc(id)
                            .delete();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

class AgregarProductosScreen extends StatelessWidget {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _empresaController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  AgregarProductosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre producto'),
            ),
            TextField(
              controller: _categoriaController,
              decoration: const InputDecoration(labelText: 'Categoría'),
            ),
            TextField(
              controller: _empresaController,
              decoration: const InputDecoration(labelText: 'Proveedor'),
            ),
            TextField(
              controller: _valorController,
              decoration: const InputDecoration(labelText: 'Valor'),
            ),
            ElevatedButton(
              onPressed: () {
                // Agrega el proveedor a firestore regresa a la pantalla anterior.
                FirebaseFirestore.instance.collection('productos').add({
                  'nombre': _nombreController.text,
                  'categoria': _categoriaController.text,
                  'empresa': _empresaController.text,
                  'valor': _valorController.text,
                }).then((value) {
                  Navigator.of(context).pop();
                });
              },
              child: const Text('Agregar producto'),
            ),
          ],
        ),
      ),
    );
  }
}
