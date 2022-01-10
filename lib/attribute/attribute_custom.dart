import 'package:hg_entity/hg_entity.dart';

/// 自定义attribute的value
abstract class CustomValue {
  /// 是否为空
  bool get isNull;

  /// 拷贝
  CustomValue clone();

  /// 合并
  CustomValue merge(CustomValue value);

  /// 转换为Map
  Future<Object?> toMap({Map<String, Object?>? args});

  /// 从Map转换
  Future<CustomValue> fromMap(Object? value, {Map<String, Object?>? args});
}

/// 自定义类型的属性
class CustomAttribute<T extends CustomValue?> extends Attribute<T> {
  CustomAttribute({
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
  T getDefaultValue() => dvalue?.clone() as T;

  @override
  bool get isNull => value == null || value!.isNull;

  @override
  T get cvalue => value?.clone() as T;
}

class CustomListAttribute<T extends CustomValue> extends ListAttribute<T> {
  CustomListAttribute({
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
  List<T> getDefaultValue() => dvalue!.map((e) => e.clone() as T).toList();

  @override
  List<T> get cvalue {
    if (isNull) return [];
    return value.map((e) => e.clone() as T).toList();
  }
}
