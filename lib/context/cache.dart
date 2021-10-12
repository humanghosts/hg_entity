import '../model/model.dart';

class ModelInitCache {
  ModelInitCache._();

  static final Map<Type, Model Function()> _cache = {};

  static void register(Type type, Model Function() constructor) {
    _cache[type] = constructor;
  }

  static T get<T extends Model>(Type type) {
    if (!_cache.containsKey(type)) {
      throw Exception("register ${type.toString()}'s constructor first");
    }
    return _cache[type]!.call() as T;
  }
}
