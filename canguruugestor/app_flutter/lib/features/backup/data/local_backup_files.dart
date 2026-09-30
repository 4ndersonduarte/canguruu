import 'dart:convert';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../../../core/failure.dart';
import '../domain/backup_files.dart';

final class LocalBackupFiles implements BackupFiles {
  static const channel = MethodChannel('br.com.canguruu/backup');
  static const type = XTypeGroup(
    label: 'Cópia Canguruu',
    extensions: ['json'],
    mimeTypes: ['application/json'],
    uniformTypeIdentifiers: ['public.json'],
  );

  @override
  Future<String?> pickBackup() async {
    final file = await openFile(acceptedTypeGroups: [type]);
    if (file == null) return null;
    if (await file.length() > 10 * 1024 * 1024) {
      throw const FinanceFailure(
        'backup_too_large',
        'Selecione uma cópia Canguruu de até 10 MB.',
      );
    }
    return file.readAsString();
  }

  @override
  Future<bool> saveBackup(String content, String name) async {
    final bytes = Uint8List.fromList(utf8.encode(content));
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return await channel.invokeMethod<bool>('saveBackup', {
            'name': name,
            'bytes': bytes,
          }) ??
          false;
    }
    final file = XFile.fromData(
      bytes,
      mimeType: 'application/json',
      name: name,
    );
    if (kIsWeb) {
      await file.saveTo(name);
      return true;
    }
    final destination = await getSaveLocation(
      suggestedName: name,
      acceptedTypeGroups: [type],
    );
    if (destination == null) return false;
    await file.saveTo(destination.path);
    return true;
  }
}
