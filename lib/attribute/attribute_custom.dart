import 'attribute.dart';
import 'attribute_list.dart';
import 'attributes.dart';
import 'listener.dart';

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
  CustomAttribute({
    required Attributes parent,
    required String name,
    required String title,
    T? dvalue,
    AttributeListener<T>? listener,
  }) : super(
          parent: parent,
          name: name,
          title: title,
          dvalue: dvalue,
          listener: listener,
        );

  @override
  bool get isNull => value == null || value!.isNull;

  @override
  T get cvalue => value?.clone() as T;
}

class CustomListAttribute<T extends CustomValue> extends ListAttribute<T> {
  CustomListAttribute({
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
  List<T> get cvalue {
    if (isNull) return [];
    return value.map((e) => e.clone() as T).toList();
  }
}
