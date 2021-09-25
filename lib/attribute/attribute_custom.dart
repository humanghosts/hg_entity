import 'package:hg_entity/attribute/listener/listener.dart';
import 'package:hg_entity/status/status.dart';

import 'attribute.dart';
import 'attribute_list.dart';

/// 自定义attribute的value
abstract class CustomValue {
  bool get isNull;

  CustomValue clone();

  void merge(CustomValue value);

  Object? toMap();

  void fromMap(Object value);
}

/// 自定义类型的属性
class CustomAttribute<T extends CustomValue?> extends Attribute<T> {
  T mvalue;

  CustomAttribute({
    required String name,
    required String title,
    required this.mvalue,
    T? dvalue,
    AttributeListener<T>? listener,
    required void Function(Attribute attribute, DataStatus status) onStatusChange,
  }) : super(
          name: name,
          title: title,
          dvalue: dvalue,
          listener: listener,
          onStatusChange: onStatusChange,
        );

  @override
  bool get isNull => value == null || value!.isNull;

  @override
  T get cvalue => value?.clone() as T;
}

class ListCustomAttribute<T extends CustomValue> extends ListAttribute<T> {
  T mvalue;

  ListCustomAttribute({
    required String name,
    required String title,
    required this.mvalue,
    List<T>? dvalue,
    ListAttributeListener<T>? listener,
    required void Function(Attribute attribute, DataStatus status) onStatusChange,
  }) : super(
          name: name,
          title: title,
          dvalue: dvalue ?? [],
          listener: listener,
          onStatusChange: onStatusChange,
        );

  @override
  List<T> get cvalue {
    if (isNull) return [];
    return value.map((e) => e.clone() as T).toList();
  }
}
