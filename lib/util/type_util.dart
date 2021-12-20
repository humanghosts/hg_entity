/// 类型工具
class TypeUtil {
  TypeUtil._();

  /// 是否可空类型
  static bool isNullable(Type type) => type.toString().endsWith("?");

  /// 获取类型的非空类型字符串
  static String getNonNullStr(Type type) {
    String typeStr = type.toString();
    String realTypeStr;
    if (isNullable(type)) {
      realTypeStr = typeStr.substring(0, typeStr.length - 1);
    } else {
      realTypeStr = typeStr;
    }
    return realTypeStr;
  }

  /// 值是否为指定类型
  static bool isThisType(Object? value, Type type) => isSameType(value.runtimeType, type);

  /// 是否相同类型 非空与可空视为同一类型
  static bool isSameType(Type a, Type b) => a.toString().replaceAll("?", "") == b.toString().replaceAll("?", "");
}
