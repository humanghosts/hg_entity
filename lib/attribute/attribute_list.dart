import 'dart:convert';

import 'attribute.dart';
import 'listener/listener.dart';
import 'states.dart';

/// 列表类型的属性
class ListAttribute<T> extends Attribute<List<T>> {
  /// [dValue]为null会赋默认值空数组
  ListAttribute({
    required String name,
    required String title,
    List<T>? dvalue,
    ListAttributeListener<T>? listener,
    required void Function(Attribute attribute, States state) onStateChange,
  }) : super(
          name: name,
          title: title,
          dvalue: dvalue ?? [],
          listener: listener,
          onStateChange: onStateChange,
        );

  /// 属性类型,List内的泛型
  @override
  Type get type => T;

  @override
  bool get isNull => value.isEmpty;

  @override
  List<T> get cvalue {
    if (isNull) return [];
    return value.map((e) => json.decode(json.encode(e)) as T).toList();
  }

  void append(T value) {
    if (null == value) {
      return;
    }
    ListAttributeListener<T>? lis = listener as ListAttributeListener<T>?;
    if (lis == null) {
      this.value.add(value);
      changeState();
      return;
    }
    Function(T value)? beforeAppendValue = lis.beforeAppendValue;
    if (null != beforeAppendValue && !beforeAppendValue(value)) {
      return;
    }
    this.value.add(value);
    changeState();
    lis.afterAppendValue?.call(value);
  }

  void appendAll(List<T> valueList) {
    for (T value in valueList) {
      append(value);
    }
  }

  void remove(T value) {
    if (null == value) {
      return;
    }
    ListAttributeListener<T>? lis = listener as ListAttributeListener<T>?;
    if (lis == null) {
      this.value.remove(value);
      changeState();
      return;
    }
    Function(T value)? beforeRemoveValue = lis.beforeRemoveValue;
    if (null != beforeRemoveValue && !beforeRemoveValue(value)) {
      return;
    }
    this.value.remove(value);
    changeState();
    lis.afterRemoveValue?.call(value);
  }

  void removeAll(List<T> valueList) {
    for (T value in valueList) {
      remove(value);
    }
  }
}

class DateTimeListAttribute extends ListAttribute<DateTime> {
  DateTimeListAttribute({
    required String name,
    required String title,
    List<DateTime>? dvalue,
    ListAttributeListener<DateTime>? listener,
    required void Function(Attribute attribute, States state) onStateChange,
  }) : super(
          name: name,
          title: title,
          dvalue: dvalue ?? [],
          listener: listener,
          onStateChange: onStateChange,
        );
}
