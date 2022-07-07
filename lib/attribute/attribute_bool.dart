import 'package:hg_entity/hg_entity.dart';

/// 布尔类型的值
class BooleanAttribute<T extends bool?> extends Attribute<T> {
  BooleanAttribute({
    required Attributes parent,
    required String name,
    String? title,
    String? comment,
    T? value,
    T? dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) : super(
          parent: parent,
          name: name,
          title: title,
          comment: comment,
          value: value,
          dvalue: dvalue,
          listenerMap: listenerMap,
        );

  @override
  String toString() {
    if (value == null) return "";
    if (value == true) return "是";
    if (value == false) return "否";
    return value.toString();
  }
}

class BooleanListAttribute<T extends bool> extends ListAttribute<T> {
  BooleanListAttribute({
    required Attributes parent,
    required String name,
    String? title,
    String? comment,
    List<T>? value,
    List<T>? dvalue,
    Map<String, ListAttributeListener<T>>? listenerMap,
  }) : super(
          parent: parent,
          name: name,
          title: title,
          comment: comment,
          value: value,
          dvalue: dvalue,
          listenerMap: listenerMap,
        );

  @override
  String toString() {
    if (value.isEmpty) return "";
    return value.map((e) {
      if (e == true) return "是";
      if (e == false) return "否";
      return e.toString();
    }).join(",");
  }
}
