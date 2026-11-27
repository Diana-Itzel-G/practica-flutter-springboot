import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../../domain/models/carrera.dart';
import '../controllers/carrera_controller.dart';
import '../widgets/confirmar_eliminar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<CarreraController>();
    final scheme = Theme.of(context).colorScheme;

    Widget body;
    if (c.loading && c.items.isEmpty) {
      body = const Center(child: CircularProgressIndicator());
    } else if (c.error != null) {
      body = Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.wifi_off_rounded, size: 64, color: scheme.primary),
            const SizedBox(height: 16),
            Text(c.error!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: c.cargar,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Reintentar'),
            ),
          ]),
        ),
      );
    } else if (c.items.isEmpty) {
      body = Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.school_outlined, size: 72, color: scheme.primary),
          const SizedBox(height: 12),
          const Text('Aún no hay carreras registradas'),
        ]),
      );
    } else {
      body = RefreshIndicator(
        onRefresh: c.cargar,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 96),
          itemCount: c.items.length + 1,
          itemBuilder: (context, i) {
            if (i == 0) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: Text(
                  '${c.items.length} carreras',
                  style: TextStyle(
                      color: scheme.primary, fontWeight: FontWeight.w600),
                ),
              );
            }
            return _CarreraCard(carrera: c.items[i - 1]);
          },
        ),
      );
    }

    return Scaffold(
      appBar: const AppBarApp(titulo: 'Carreras'),
      body: body,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/nuevo'),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Nueva'),
      ),
    );
  }
}

class _CarreraCard extends StatelessWidget {
  const _CarreraCard({required this.carrera});
  final Carrera carrera;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final c = context.read<CarreraController>();

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/carrera/${carrera.id}'),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 4, 12),
          child: Row(children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              alignment: Alignment.center,
              child: Text(
                carrera.nombre.isNotEmpty ? carrera.nombre[0] : '?',
                style: TextStyle(
                    color: scheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(carrera.nombre,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Wrap(spacing: 6, runSpacing: 4, children: [
                    _Chip(
                        icon: Icons.schedule_rounded,
                        texto: '${carrera.duracionSemestres} semestres'),
                    _Chip(icon: Icons.class_outlined, texto: carrera.modalidad),
                  ]),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Eliminar',
              icon: Icon(Icons.delete_outline_rounded, color: scheme.error),
              onPressed: () => confirmarEliminar(context, c, carrera),
            ),
          ]),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.texto});
  final IconData icon;
  final String texto;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 14, color: scheme.onPrimaryContainer),
        const SizedBox(width: 4),
        Text(texto,
            style:
                TextStyle(fontSize: 12, color: scheme.onPrimaryContainer)),
      ]),
    );
  }
}
