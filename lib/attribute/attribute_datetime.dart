import 'package:hg_entity/hg_entity.dart';

/// 时间类型
class DateTimeAttribute<T extends DateTime?> extends Attribute<T> {
  DateTimeAttribute({
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
  void setValueFromDefault() {
    value = DateTime.fromMillisecondsSinceEpoch((dvalue as DateTime).millisecondsSinceEpoch) as T;
  }

  @override
  T get cvalue {
    if (isNull) {
      return null as T;
    }
    return DateTime.fromMillisecondsSinceEpoch((value as DateTime).millisecondsSinceEpoch) as T;
  }
}

class DateTimeListAttribute<T extends DateTime> extends ListAttribute<T> {
  DateTimeListAttribute({
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
  void setValueFromDefault() {
    value = dvalue?.map((e) => DateTime.fromMillisecondsSinceEpoch(e.millisecondsSinceEpoch) as T).toList() as List<T>;
  }

  @override
  List<T> get cvalue {
    if (isNull) return [];
    return value.map((e) => DateTime.fromMillisecondsSinceEpoch(e.millisecondsSinceEpoch) as T).toList();
  }
}
