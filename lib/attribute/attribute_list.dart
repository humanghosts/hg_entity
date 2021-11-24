import 'dart:convert';

import 'attribute.dart';
import 'attributes.dart';
import 'listener.dart';

/// 列表类型的属性
class ListAttribute<T> extends Attribute<List<T>> {
  /// [dValue]为null会赋默认值空数组
  ListAttribute({
    required Attributes parent,
    required String name,
    required String title,
    List<T>? dvalue,
    ListAttributeListener<T>? listener,
  }) : super(
          parent: parent,
          name: name,
          title: title,
          dvalue: dvalue ?? [],
          listener: listener,
        );

  @override
  List<T> initValue() {
    return dvalue?.map(initValueEach).toList() ?? [];
  }

  T initValueEach(T value) {
    T value;
    if (T == DateTime || dvalue is DateTime) {
      value = DateTime.fromMillisecondsSinceEpoch((dvalue as DateTime).millisecondsSinceEpoch) as T;
    } else {
      value = json.decode(json.encode(dvalue)) as T;
    }
    return value;
  }

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

  @override
  set valueTypeless(dynamic value) {
    assert(value is List);
    this.value = (value as List).map((e) => e as T).toList();
  }

  void append(T value) {
    insert(this.value.length, value);
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
      parent.listener?.onListAttributeValueRemove?.call(this, value);

      return;
    }
    Function(T value)? beforeRemoveValue = lis.beforeRemoveValue;
    if (null != beforeRemoveValue && !beforeRemoveValue(value)) {
      return;
    }
    this.value.remove(value);
    lis.afterRemoveValue?.call(value);
    parent.listener?.onListAttributeValueRemove?.call(this, value);
  }

  void removeAt(int index) {
    if (index >= this.value.length) {
      return;
    }
    T value = this.value[index];
    remove(value);
  }

  void removeAll(List<T> valueList) {
    for (T value in valueList) {
      remove(value);
    }
  }

  void insert(int index, T value) {
    if (null == value || index > this.value.length || index < 0) {
      return;
    }
    ListAttributeListener<T>? lis = listener as ListAttributeListener<T>?;
    if (lis == null) {
      this.value.insert(index, value);
      parent.listener?.onListAttributeValueAdd?.call(this, index, value);
      return;
    }
    Function(int index, T value)? beforeAppendValue = lis.beforeAddValue;
    if (null != beforeAppendValue && !beforeAppendValue(index, value)) {
      return;
    }
    this.value.insert(index, value);
    lis.afterAddValue?.call(index, value);
    parent.listener?.onListAttributeValueAdd?.call(this, index, value);
  }

  @override
  void clear({bool reset = true}) {
    List<T> allValue = [...value];
    removeAll(allValue);
  }
}

class DateTimeListAttribute extends ListAttribute<DateTime> {
  DateTimeListAttribute({
    required Attributes parent,
    required String name,
    required String title,
    List<DateTime>? dvalue,
    ListAttributeListener<DateTime>? listener,
  }) : super(
          parent: parent,
          name: name,
          title: title,
          dvalue: dvalue ?? [],
          listener: listener,
        );
}
