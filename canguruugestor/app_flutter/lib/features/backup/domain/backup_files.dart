abstract interface class BackupFiles {
  Future<String?> pickBackup();
  Future<bool> saveBackup(String content, String name);
}
