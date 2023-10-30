import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditarProducto extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String productoId;
  final String nombreActual;
  final String categoriaActual;
  final String proveedorActual;
  final String valorActual;

  const EditarProducto({
    super.key,
    required this.productoId,
    required this.nombreActual,
    required this.categoriaActual,
    required this.proveedorActual,
    required this.valorActual,
    required nombre,
    required categoria,
    required proveedor,
    required valor,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EditarProductoState createState() => _EditarProductoState();
}

class _EditarProductoState extends State<EditarProducto> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _proveedorController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializa los controladores con los valores actuales del Producto
    _nombreController.text = widget.nombreActual;
    _categoriaController.text = widget.categoriaActual;
    _proveedorController.text = widget.proveedorActual;
    _valorController.text = widget.valorActual;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _categoriaController,
              decoration: const InputDecoration(labelText: 'Categoría'),
            ),
            TextField(
              controller: _proveedorController,
              decoration: const InputDecoration(labelText: 'Proveedor'),
            ),
            TextField(
              controller: _valorController,
              decoration: const InputDecoration(labelText: 'Valor'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Actualiza el Producto en firestore y vuelve a la pág anterior
                await FirebaseFirestore.instance
                    .collection('productos')
                    .doc(widget.productoId)
                    .update({
                  'nombre': _nombreController.text,
                  'categoria': _categoriaController.text,
                  'proveedor': _proveedorController.text,
                  'valor': _valorController.text,
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
