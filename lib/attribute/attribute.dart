import 'dart:convert';

import 'listener/listener.dart';

class Attribute<T> {
  /// 字段值
  late T _value;

  /// 字段默认值
  late T? _dvalue;

  /// 字段名称
  late final String _name;

  /// 字段标题
  late final String _title;

  /// 监听器
  late final AttributeListener<T>? _listener;

  /// 构造方法:
  /// [name] 字段名称;
  /// [title] 字段标题,为空使用[name]的值;
  /// [dvalue] 默认值;
  Attribute({
    required String name,
    required String title,
    T? dvalue,
    AttributeListener<T>? listener,
  }) {
    _name = name;
    _title = title;
    _dvalue = dvalue;
    if (null != dvalue) _value = dvalue;
    _listener = listener;
  }

  /// 获取字段值
  T get value => _value;

  /// 获取字段名
  String get name => _name;

  /// 获取字段标题
  String get title => _title;

  /// 获取字段值类型
  Type get type => T;

  /// 获取值是否为空
  bool get isNull => value == null;

  /// 获取默认值
  T? get dvalue => _dvalue;

  /// 获取值拷贝
  T get cvalue => json.decode(json.encode(value));

  AttributeListener<T>? get listener => _listener;

  /// 设置字段值
  set value(T value) {
    AttributeListener<T>? lis = listener;
    if (null == lis) {
      _value = value;
      return;
    }
    bool Function(T value)? beforeSetValue = lis.beforeSetValue;
    if (beforeSetValue != null && !beforeSetValue(value)) {
      return;
    }
    lis.beforeSetValue?.call(value);
  }

  /// 清空值，如果有默认值
  void clear({bool reset = true}) {
    if (null != dvalue && reset) {
      value = dvalue as T;
    } else {
      value = null as T;
    }
  }

  @override
  String toString() {
    return {
      "name": name,
      "value": value,
      "title": title,
      "type": T,
      "dvalue": dvalue,
    }.toString();
  }
}
