import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@singleton
@injectable
class HiveStorageHelper {
  static final HiveStorageHelper _instance = HiveStorageHelper._internal();

  factory HiveStorageHelper() => _instance;

  HiveStorageHelper._internal();

  static const String _defaultBoxName = 'app_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_defaultBoxName);
  }

  Future<void> saveString(String key, String value, {String boxName = _defaultBoxName}) async {
    final box = Hive.box(boxName);
    await box.put(key, value);
  }

  Future<void> saveInt(String key, int value, {String boxName = _defaultBoxName}) async {
    final box = Hive.box(boxName);
    await box.put(key, value);
  }

  Future<void> saveDouble(String key, double value, {String boxName = _defaultBoxName}) async {
    final box = Hive.box(boxName);
    await box.put(key, value);
  }

  Future<void> saveBool(String key, bool value, {String boxName = _defaultBoxName}) async {
    final box = Hive.box(boxName);
    await box.put(key, value);
  }

  Future<void> saveStringList(String key, List<String> value, {String boxName = _defaultBoxName}) async {
    final box = Hive.box(boxName);
    await box.put(key, value);
  }

  Future<void> saveMap(String key, Map<dynamic, dynamic> value, {String boxName = _defaultBoxName}) async {
    final box = Hive.box(boxName);
    await box.put(key, value);
  }

  String? getString(String key, {String boxName = _defaultBoxName}) {
    final box = Hive.box(boxName);
    return box.get(key) as String?;
  }

  int? getInt(String key, {String boxName = _defaultBoxName}) {
    final box = Hive.box(boxName);
    return box.get(key) as int?;
  }

  double? getDouble(String key, {String boxName = _defaultBoxName}) {
    final box = Hive.box(boxName);
    return box.get(key) as double?;
  }

  bool? getBool(String key, {String boxName = _defaultBoxName}) {
    final box = Hive.box(boxName);
    return box.get(key) as bool?;
  }

  List<String>? getStringList(String key, {String boxName = _defaultBoxName}) {
    final box = Hive.box(boxName);
    final list = box.get(key) as List<dynamic>?;
    return list?.map((e) => e.toString()).toList();
  }
  
  Map<dynamic, dynamic>? getMap(String key, {String boxName = _defaultBoxName}) {
    final box = Hive.box(boxName);
    return box.get(key) as Map<dynamic, dynamic>?;
  }

  Future<void> remove(String key, {String boxName = _defaultBoxName}) async {
    final box = Hive.box(boxName);
    await box.delete(key);
  }

  Future<void> clear({String boxName = _defaultBoxName}) async {
    final box = Hive.box(boxName);
    await box.clear();
  }

  Future<void> closeBox({String boxName = _defaultBoxName}) async {
    final box = Hive.box(boxName);
    await box.close();
  }
}
