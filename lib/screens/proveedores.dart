import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examen_machuca/services/proveedores_services.dart';
import 'package:flutter/material.dart';

class Proveedores {
  final String id;
  final String empresa;
  final String categoria;

  Proveedores({
    required this.id,
    required this.empresa,
    required this.categoria,
  });
}

class ProveedoresScreen extends StatelessWidget {
  const ProveedoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de proveedores'),
      ),
      body: const ProveedoresList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navega a la pantalla de agregar un nuevo proveedor.
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AgregarProveedorScreen()));
        },
        backgroundColor: const Color.fromARGB(255, 54, 244, 111),
        child: const Icon(Icons.add_business_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, // Centra el botón en la parte inferior.
    );
  }
}

class ProveedoresList extends StatelessWidget {
  const ProveedoresList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('proveedores').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var proveedor = snapshot.data?.docs[index];
              var data = proveedor?.data() as Map<String, dynamic>;
              var id = proveedor?.id;

              return ListTile(
                title: Text("Empresa: ${data['empresa']}"),
                subtitle: Text("Categoría: ${data['categoria']}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_sharp),
                      color: const Color.fromARGB(255, 29, 98, 167),
                      onPressed: () {
                        // Obtiene los valores del proveedor seleccionado
                        String proveedorId = proveedor!.id;
                        String empresaActual = data['empresa'];
                        String categoriaActual = data['categoria'];

                        // Navega a la pantalla de edición con los datos actuales del proveedor.
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditarProveedor(
                              proveedorId: proveedorId,
                              empresaActual: empresaActual,
                              empresa: null,
                              categoriaActual: categoriaActual,
                              categoria: null,
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
                            .collection('proveedores')
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

class AgregarProveedorScreen extends StatelessWidget {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();

  AgregarProveedorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Proveedor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre Empresa'),
            ),
            TextField(
              controller: _categoriaController,
              decoration: const InputDecoration(labelText: 'Categoría'),
            ),
            ElevatedButton(
              onPressed: () {
                // Agrega el proveedor a Firebase Firestore y regresa a la pantalla anterior.
                FirebaseFirestore.instance.collection('proveedores').add({
                  'empresa': _nombreController.text,
                  'categoria': _categoriaController.text,
                }).then((value) {
                  Navigator.of(context).pop();
                });
              },
              child: const Text('Agregar Proveedor'),
            ),
          ],
        ),
      ),
    );
  }
}
