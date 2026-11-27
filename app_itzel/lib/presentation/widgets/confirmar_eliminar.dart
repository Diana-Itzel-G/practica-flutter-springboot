import 'package:flutter/material.dart';

import '../../domain/models/carrera.dart';
import '../controllers/carrera_controller.dart';

/// Pide confirmación y, si se acepta, hace el DELETE /api/carreras/{id}.
/// Devuelve true si la carrera se eliminó.
Future<bool> confirmarEliminar(
    BuildContext context, CarreraController c, Carrera carrera) async {
  final scheme = Theme.of(context).colorScheme;
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      icon: Icon(Icons.delete_forever_rounded, color: scheme.error, size: 40),
      title: const Text('¿Eliminar carrera?'),
      content: Text(
        'Se eliminará "${carrera.nombre}" junto con sus estudiantes '
        'e inscripciones. Esta acción no se puede deshacer.',
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            elevation: 0,
            backgroundColor: scheme.error,
            minimumSize: const Size(120, 44),
          ),
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Eliminar'),
        ),
      ],
    ),
  );
  if (ok != true || !context.mounted) return false;

  final msg = await c.eliminar(carrera.id!);
  if (!context.mounted) return msg == null;
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg ?? '"${carrera.nombre}" eliminada'),
    backgroundColor: msg == null ? null : scheme.error,
  ));
  return msg == null;
}
