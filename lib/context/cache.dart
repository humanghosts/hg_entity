import 'package:hg_entity/hg_entity.dart';

class ConstructorCache {
  ConstructorCache._();

  static final Map<String, Object Function([Map<String, dynamic>? args])> _cache = {};

  static final Set<String> _simpleModelCache = {};
  static final Set<String> _dataModelCache = {};
  static final Set<String> _customValueCache = {};
  static final Set<String> _unknownTypeCache = {};

  static void put(Type type, Object Function([Map<String, dynamic>? args]) constructor) {
    String typeStr = "$type";
    String typeStrNullable = "$type?";
    _cache[typeStr] = constructor;
    _cache[typeStrNullable] = constructor;
    var value = constructor.call();
    if (value is DataModel) {
      _dataModelCache.add(typeStr);
      _dataModelCache.add(typeStrNullable);
    } else if (value is SimpleModel) {
      _simpleModelCache.add(typeStr);
      _simpleModelCache.add(typeStrNullable);
    } else if (value is CustomValue) {
      _customValueCache.add(typeStr);
      _customValueCache.add(typeStrNullable);
    } else {
      _unknownTypeCache.add(typeStr);
      _unknownTypeCache.add(typeStrNullable);
    }
  }

  static Type getRawType(Type type) {
    if (_dataModelCache.contains("$type")) {
      return DataModel;
    }
    if (_simpleModelCache.contains("$type")) {
      return SimpleModel;
    }
    if (_customValueCache.contains("$type")) {
      return CustomValue;
    }
    return Object;
  }

  static Type getRawTypeStr(String type) {
    if (_dataModelCache.contains(type)) {
      return DataModel;
    }
    if (_simpleModelCache.contains(type)) {
      return SimpleModel;
    }
    if (_customValueCache.contains(type)) {
      return CustomValue;
    }
    return Object;
  }

  static T get<T>(Type type, [Map<String, dynamic>? args]) {
    return getStr("$type");
  }

  static T getStr<T>(String type, [Map<String, dynamic>? args]) {
    assert(_cache.containsKey(type), "register ${type.toString()}'s constructor first");
    return _cache[type]!.call(args) as T;
  }

  static bool containsKey(Type type) {
    return containsKeyStr("$type");
  }

  static bool containsKeyStr(String type) {
    return _cache.containsKey(type);
  }
}
