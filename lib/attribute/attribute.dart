import 'dart:convert';

import 'attributes.dart';
import 'listener.dart';

class Attribute<T> {
  /// 字段值
  T _value;

  /// 字段默认值
  final T? dvalue;

  /// 字段名称
  final String name;

  /// 字段标题
  final String title;

  /// 监听器
  final AttributeListener<T>? listener;

  final Attributes parent;

  /// 构造方法:
  /// [name] 字段名称;
  /// [title] 字段标题,为空使用[name]的值;
  /// [dvalue] 默认值;
  Attribute({
    required this.parent,
    required this.name,
    required this.title,
    this.dvalue,
    this.listener,
  }) : _value = dvalue as T;

  /// 获取字段值
  T get value => _value;

  /// 获取字段值类型
  Type get type => T;

  /// 获取值是否为空
  bool get isNull => value == null;

  /// 获取值拷贝
  T get cvalue => json.decode(json.encode(value));

  /// 设置字段值
  set value(T value) {
    AttributeListener<T>? lis = listener;
    T oldValue = this.value;
    if (null == lis) {
      _value = value;
      parent.listener?.onAttributeValueChange?.call(this, oldValue, this.value);
      return;
    }
    bool Function(T value)? beforeSetValue = lis.beforeSetValue;
    if (beforeSetValue != null && !beforeSetValue(value)) {
      return;
    }
    _value = value;
    lis.afterSetValue?.call(value);
    parent.listener?.onAttributeValueChange?.call(this, oldValue, this.value);
  }

  /// 清空值，如果有默认值
  void clear({bool reset = true}) {
    T oldValue = value;
    if (null != dvalue && reset) {
      value = dvalue as T;
    } else {
      value = null as T;
    }
    parent.listener?.onAttributeValueChange?.call(this, oldValue, value);
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
