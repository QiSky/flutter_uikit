import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CacheUtil {
  static CacheUtil? _instance;

  static CacheUtil getInstance() {
    if (_instance == null) _instance = CacheUtil();
    return _instance!;
  }

  void clearCache({Function? onComplete}) async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      await deleteDir(tempDir);
    } finally {
      if (onComplete != null) onComplete();
    }
  }

  Future<String> loadCache(Function onComplete) async {
    Directory tempDir = await getTemporaryDirectory();
    String size =
        _renderSize(await _getTotalSizeOfFilesInDir(tempDir)).toString();
    onComplete(size);
    return size;
  }

  dynamic _renderSize(double value) {
    List<String> unitArr = ['B', 'K', 'M', 'G'];
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  static Future<double> _getTotalSizeOfFilesInDir(
      final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List<FileSystemEntity>? children = file.listSync();
      double total = 0;
      if (children != null)
        for (final FileSystemEntity child in children)
          total += await _getTotalSizeOfFilesInDir(child);
      return total;
    }
    return 0;
  }

  ///递归方式删除目录
  Future<Null> deleteDir(FileSystemEntity file) async {
    if (file is Directory) {
      file.exists().then((value) async {
        final List<FileSystemEntity> children = file.listSync();
        for (final FileSystemEntity child in children) {
          await deleteDir(child);
        }
      });
    }
  }
}
