import 'package:hg_entity/attribute/listener/listener.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_entity/status/status.dart';

import 'attribute.dart';

class ModelAttribute<T extends Model?> extends Attribute<T> {
  ModelAttribute({
    required String name,
    required String title,
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
  T get cvalue => value?.clone() as T;
}

class ModelListAttribute<T extends Model> extends ListAttribute<T> {
  ModelListAttribute({
    required String name,
    required String title,
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

class DataModelAttribute<T extends DataModel?> extends ModelAttribute<T> {
  DataModelAttribute({
    required String name,
    required String title,
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
}

class DataModelListAttribute<T extends DataModel> extends ModelListAttribute<T> {
  DataModelListAttribute({
    required String name,
    required String title,
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
}

class DataTreeModelAttribute<T extends DataTreeModel?> extends DataModelAttribute<T> {
  DataTreeModelAttribute({
    required String name,
    required String title,
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
}

class DataTreeModelListAttribute<T extends DataTreeModel> extends DataModelListAttribute<T> {
  DataTreeModelListAttribute({
    required String name,
    required String title,
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
}

class SimpleModelAttribute<T extends SimpleModel?> extends ModelAttribute<T> {
  SimpleModelAttribute({
    required String name,
    required String title,
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
}

class SimpleModelListAttribute<T extends SimpleModel> extends ModelListAttribute<T> {
  SimpleModelListAttribute({
    required String name,
    required String title,
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
}
