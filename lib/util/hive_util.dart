import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveUtil {
  static Future<void> init([List<TypeAdapter<dynamic>>? adapters]) async {
    final Directory directory = await getApplicationSupportDirectory();
    Hive.init(directory.path);
    adapters?.forEach((TypeAdapter element) {
      Hive.registerAdapter(element);
    });
  }

  static Future<void> save<T>(String key, T data) async {
    late Box<T> box;
    if (Hive.isBoxOpen(key)) {
      box = Hive.box<T>(key);
    } else {
      box = await Hive.openBox<T>(key);
    }
    box.put(key, data);
    if (T is HiveObject) {
      (data as HiveObject).save();
    }
  }

  static Future<T> get<T>(String key) async {
    late Box<T> box;
    if (Hive.isBoxOpen(key)) {
      box = Hive.box<T>(key);
    } else {
      box = await Hive.openBox<T>(key);
    }
    return Future<T>.value(box.get(key));
  }

  static Future<void> delete(List<String> keys) async {
    keys.forEach((String element) async {
      Box box;
      if (Hive.isBoxOpen(element)) {
        box = Hive.box(element);
      } else {
        box = await Hive.openBox(element);
      }
      box.clear();
    });
  }

  static Future<void> deleteKey<T>(key) async {
    late Box<T> box;
    if (Hive.isBoxOpen(key)) {
      box = Hive.box(key);
    } else {
      box = await Hive.openBox(key);
    }
    box.clear();
  }

  static Future<void> close(List<String> keys) async {
    keys.forEach((String element) async {
      final Box box = await Hive.openBox(element);
      box.close();
    });
  }
}
