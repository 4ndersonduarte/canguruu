import 'brand_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../app/providers.dart';
import '../../core/civil_date.dart';
import 'components.dart';

class FormPanel extends StatelessWidget {
  const FormPanel({
    super.key,
    required this.title,
    required this.children,
    required this.busy,
    required this.onSubmit,
    this.error,
    this.submitLabel = 'Salvar',
  });
  final String title;
  final List<Widget> children;
  final bool busy;
  final VoidCallback onSubmit;
  final String? error;
  final String submitLabel;
  @override
  Widget build(BuildContext context) => PopScope(
    canPop: !busy,
    child: Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Fechar',
                    onPressed: busy ? null : () => Navigator.pop(context),
                    icon: const CanguruuIcon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AbsorbPointer(
                absorbing: busy,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final child in children) ...[
                      child,
                      const SizedBox(height: 16),
                    ],
                  ],
                ),
              ),
              if (error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    error!,
                    key: const Key('form-error'),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  key: const Key('submit-form'),
                  onPressed: busy ? null : onSubmit,
                  child: Text(busy ? 'Salvando…' : submitLabel),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

mixin SubmitState<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  final requestId = const Uuid().v4();
  bool busy = false;
  String? error;
  Future<void> submit(Future<Object?> Function() operation) async {
    if (busy) return;
    setState(() {
      busy = true;
      error = null;
    });
    try {
      await operation();
      if (mounted) {
        Navigator.pop(context);
        notifyUser(context, 'Registro salvo neste dispositivo.');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          error = friendlyError(e);
          busy = false;
        });
      }
    }
  }
}

class DateField extends ConsumerWidget {
  const DateField({
    super.key,
    required this.date,
    required this.onChanged,
    this.label = 'Data',
    this.allowFuture = false,
  });
  final CivilDate date;
  final ValueChanged<CivilDate> onChanged;
  final String label;
  final bool allowFuture;
  @override
  Widget build(BuildContext context, WidgetRef ref) => OutlinedButton.icon(
    onPressed: () async {
      final chosen = await showDatePicker(
        context: context,
        initialDate: date.dateTime,
        firstDate: DateTime(1900),
        lastDate: allowFuture
            ? DateTime(9999, 12, 31)
            : ref.read(clockProvider).today.dateTime,
      );
      if (chosen != null) onChanged(CivilDate.fromDateTime(chosen));
    },
    icon: const CanguruuIcon(Icons.calendar_today_outlined, size: 18),
    label: Text('$label: ${date.display}'),
  );
}
