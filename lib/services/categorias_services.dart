import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditarCategoria extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String categoriaId;
  final String nombreActual;

  const EditarCategoria({
    super.key,
    required this.categoriaId,
    required this.nombreActual,
    required nombre,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EditarCategoriaState createState() => _EditarCategoriaState();
}

class _EditarCategoriaState extends State<EditarCategoria> {
  final TextEditingController _nombreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializa los controladores con los valores actuales del Producto
    _nombreController.text = widget.nombreActual;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Categoría'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Actualiza el Producto en firestore y vuelve a la pág anterior
                await FirebaseFirestore.instance
                    .collection('categorias')
                    .doc(widget.categoriaId)
                    .update({
                  'nombre': _nombreController.text,
                });
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
