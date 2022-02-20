import 'package:hg_entity/hg_entity.dart';

/// 模型
class ModelAttribute<T extends Model?> extends Attribute<T> {
  ModelAttribute({
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
  T get cvalue => value?.clone() as T;
}

class ModelListAttribute<T extends Model> extends ListAttribute<T> {
  ModelListAttribute({
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
  List<T> getDefaultValue() => dvalue?.map((e) => e.clone() as T).toList() as List<T>;

  @override
  List<T> get cvalue {
    if (isNull) return [];
    return value.map((e) => e.clone() as T).toList();
  }
}

class DataModelAttribute<T extends DataModel?> extends ModelAttribute<T> {
  DataModelAttribute({
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

class DataModelListAttribute<T extends DataModel> extends ModelListAttribute<T> {
  DataModelListAttribute({
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

class DataTreeModelAttribute<T extends DataTreeModel?> extends DataModelAttribute<T> {
  DataTreeModelAttribute({
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

class DataTreeModelListAttribute<T extends DataTreeModel> extends DataModelListAttribute<T> {
  DataTreeModelListAttribute({
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

class SimpleModelAttribute<T extends SimpleModel?> extends ModelAttribute<T> {
  SimpleModelAttribute({
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

class SimpleModelListAttribute<T extends SimpleModel> extends ModelListAttribute<T> {
  SimpleModelListAttribute({
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
