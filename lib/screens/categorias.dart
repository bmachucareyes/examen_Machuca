import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examen_machuca/services/categorias_services.dart';
import 'package:flutter/material.dart';

class Categorias {
  final String id;
  final String nombre;

  Categorias({
    required this.id,
    required this.nombre,
  });
}

class CategoriasScreen extends StatelessWidget {
  const CategoriasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de categorías'),
      ),
      body: const CategoriasList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navega a la pantalla de agregar un nueva categoría
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AgregarCategoriasScreen()));
        },
        backgroundColor: const Color.fromARGB(255, 54, 244, 111),
        child: const Icon(Icons.category_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class CategoriasList extends StatelessWidget {
  const CategoriasList({super.key});

  get categoria => null;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('categorias').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var categoria = snapshot.data?.docs[index];
              var data = categoria?.data() as Map<String, dynamic>;
              var id = categoria?.id;

              return ListTile(
                title: Text("Nombre: ${data['nombre']}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_sharp),
                      color: const Color.fromARGB(255, 29, 98, 167),
                      onPressed: () {
                        // Obtiene los valores del producto seleccionado
                        String categoriaId = categoria!.id;
                        String nombreActual = data['nombre'];

                        // Navega a la pantalla de edición con los datos actuales del producto.
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditarCategoria(
                              categoriaId: categoriaId,
                              nombreActual: nombreActual,
                              nombre: null,
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
                            .collection('categorias')
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

class AgregarCategoriasScreen extends StatelessWidget {
  final TextEditingController _nombreController = TextEditingController();

  AgregarCategoriasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear categoría'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Categoria'),
            ),
            ElevatedButton(
              onPressed: () {
                // Agrega el proveedor a firestore regresa a la pantalla anterior.
                FirebaseFirestore.instance.collection('categorias').add({
                  'nombre': _nombreController.text,
                }).then((value) {
                  Navigator.of(context).pop();
                });
              },
              child: const Text('Crear categoría'),
            ),
          ],
        ),
      ),
    );
  }
}
