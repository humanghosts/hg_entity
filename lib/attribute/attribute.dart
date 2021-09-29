import 'dart:convert';

import 'listener/listener.dart';
import 'states.dart';

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

  /// 字段状态
  States _state = States.none;

  /// 字段状态修改，修改模型状态
  late final void Function(Attribute attribute, States state) _onStateChange;

  /// 构造方法:
  /// [name] 字段名称;
  /// [title] 字段标题,为空使用[name]的值;
  /// [dvalue] 默认值;
  Attribute({
    required String name,
    required String title,
    T? dvalue,
    AttributeListener<T>? listener,
    required void Function(Attribute attribute, States oldState) onStateChange,
  }) {
    _name = name;
    _title = title;
    _dvalue = dvalue;
    if (null != dvalue) _value = dvalue;
    _listener = listener;
    _onStateChange = onStateChange;
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

  States get state => _state;

  void Function(Attribute attribute, States oldState) get onStateChange => _onStateChange;

  void changeState({States newState = States.update}) {
    States oldState = _state;
    if (oldState != newState) {
      _state = newState;
      onStateChange(this, oldState);
    }
  }

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
