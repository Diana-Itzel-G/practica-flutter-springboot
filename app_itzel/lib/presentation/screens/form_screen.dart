import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../controllers/carrera_controller.dart';

/// Sin id hace el POST; con id hace el PUT.
class FormScreen extends StatefulWidget {
  const FormScreen({super.key, this.id});
  final int? id;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final nombre = TextEditingController();
  final semestres = TextEditingController();
  final List<String> modalidades = ['Escolarizada', 'Mixta', 'En línea'];
  String? modalidad;
  bool guardando = false;

  bool get editando => widget.id != null;

  @override
  void initState() {
    super.initState();
    if (editando) {
      final d = context.read<CarreraController>().detalle;
      if (d != null && d.id == widget.id) {
        nombre.text = d.nombre;
        semestres.text = '${d.duracionSemestres}';
        if (d.modalidad.isNotEmpty && !modalidades.contains(d.modalidad)) {
          modalidades.add(d.modalidad);
        }
        modalidad = d.modalidad.isEmpty ? null : d.modalidad;
      }
    }
  }

  @override
  void dispose() {
    nombre.dispose();
    semestres.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    final s = int.parse(semestres.text.trim());
    setState(() => guardando = true);
    final c = context.read<CarreraController>();
    final error = editando
        ? await c.actualizar(widget.id!, nombre.text.trim(), s, modalidad!)
        : await c.crear(nombre.text.trim(), s, modalidad!);
    if (!mounted) return;
    setState(() => guardando = false);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return;
    }
    if (editando) await c.cargarDetalle(widget.id!);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(editando ? 'Carrera actualizada' : 'Carrera creada')));
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBarApp(titulo: editando ? 'Editar carrera' : 'Nueva carrera'),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: CircleAvatar(
                radius: 36,
                backgroundColor: scheme.primaryContainer,
                child: Icon(
                    editando ? Icons.edit_note_rounded : Icons.add_card_rounded,
                    size: 36,
                    color: scheme.onPrimaryContainer),
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: nombre,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                prefixIcon: Icon(Icons.school_outlined),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Escribe el nombre' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: semestres,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Duración (semestres)',
                prefixIcon: Icon(Icons.schedule_rounded),
              ),
              validator: (v) {
                final n = int.tryParse(v?.trim() ?? '');
                return (n == null || n <= 0) ? 'Escribe un número válido' : null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: modalidad,
              decoration: const InputDecoration(
                labelText: 'Modalidad',
                prefixIcon: Icon(Icons.class_outlined),
              ),
              items: [
                for (final m in modalidades)
                  DropdownMenuItem(value: m, child: Text(m)),
              ],
              onChanged: (v) => setState(() => modalidad = v),
              validator: (v) => v == null ? 'Elige la modalidad' : null,
            ),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: guardando ? null : _guardar,
              icon: guardando
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.check_rounded),
              label: Text(guardando ? 'Guardando...' : 'Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
