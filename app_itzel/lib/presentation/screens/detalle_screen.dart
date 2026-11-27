import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../controllers/carrera_controller.dart';
import '../widgets/confirmar_eliminar.dart';

class DetalleScreen extends StatefulWidget {
  const DetalleScreen({super.key, required this.id});
  final int id;

  @override
  State<DetalleScreen> createState() => _DetalleScreenState();
}

class _DetalleScreenState extends State<DetalleScreen> {
  @override
  void initState() {
    super.initState();
    // GET /api/carreras/{id}
    final c = context.read<CarreraController>();
    Future.microtask(() => c.cargarDetalle(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<CarreraController>();
    final d = c.detalle;
    final scheme = Theme.of(context).colorScheme;

    Widget body;
    if (c.loadingDetalle) {
      body = const Center(child: CircularProgressIndicator());
    } else if (c.errorDetalle != null || d == null) {
      body = Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.search_off_rounded, size: 64, color: scheme.primary),
          const SizedBox(height: 12),
          Text(c.errorDetalle ?? 'Sin datos'),
        ]),
      );
    } else {
      body = ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.azulPetroleo,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(children: [
              const CircleAvatar(
                radius: 34,
                backgroundColor: Colors.white,
                child: Icon(Icons.school_rounded,
                    size: 38, color: AppTheme.azulPetroleo),
              ),
              const SizedBox(height: 14),
              Text(
                d.nombre,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text('Carrera #${d.id}',
                  style: const TextStyle(color: Colors.white70)),
            ]),
          ),
          const SizedBox(height: 20),
          Card(
            margin: EdgeInsets.zero,
            child: Column(children: [
              _Dato(
                  icon: Icons.schedule_rounded,
                  titulo: 'Duración',
                  valor: '${d.duracionSemestres} semestres'),
              const Divider(height: 1, indent: 16, endIndent: 16),
              _Dato(
                  icon: Icons.class_outlined,
                  titulo: 'Modalidad',
                  valor: d.modalidad),
            ]),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => context.push('/editar/${d.id}'),
            icon: const Icon(Icons.edit_rounded),
            label: const Text('Editar'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: scheme.error,
              side: BorderSide(color: scheme.error),
            ),
            onPressed: () async {
              final borrada = await confirmarEliminar(context, c, d);
              if (borrada && context.mounted) context.pop();
            },
            icon: const Icon(Icons.delete_outline_rounded),
            label: const Text('Eliminar'),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: const AppBarApp(titulo: 'Detalle'),
      body: body,
    );
  }
}

class _Dato extends StatelessWidget {
  const _Dato({required this.icon, required this.titulo, required this.valor});
  final IconData icon;
  final String titulo;
  final String valor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: scheme.primaryContainer,
        child: Icon(icon, color: scheme.onPrimaryContainer),
      ),
      title: Text(titulo,
          style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant)),
      subtitle: Text(valor,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }
}
