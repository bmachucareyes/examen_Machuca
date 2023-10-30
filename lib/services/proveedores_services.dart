import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditarProveedor extends StatefulWidget {
  final String proveedorId;
  final String empresaActual;
  final String categoriaActual;

  const EditarProveedor({
    super.key,
    required this.proveedorId,
    required this.empresaActual,
    required this.categoriaActual,
    required categoria,
    required empresa,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EditarProveedorState createState() => _EditarProveedorState();
}

class _EditarProveedorState extends State<EditarProveedor> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializa los controladores con los valores actuales del proveedor
    _nombreController.text = widget.empresaActual;
    _categoriaController.text = widget.categoriaActual;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Proveedor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Empresa'),
            ),
            TextField(
              controller: _categoriaController,
              decoration: const InputDecoration(labelText: 'Categoría'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Actualiza el proveedor en firestore y vuelve a la pág anterior
                await FirebaseFirestore.instance
                    .collection('proveedores')
                    .doc(widget.proveedorId)
                    .update({
                  'empresa': _nombreController.text,
                  'categoria': _categoriaController.text,
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
