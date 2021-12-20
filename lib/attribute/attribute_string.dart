import 'package:hg_entity/hg_entity.dart';

/// 字符串类型属性
class StringAttribute<T extends String?> extends Attribute<T> {
  StringAttribute({
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
}

class StringListAttribute<T extends String> extends ListAttribute<T> {
  StringListAttribute({
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
}
