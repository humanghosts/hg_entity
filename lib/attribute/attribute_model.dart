import '../model/export.dart';
import 'attribute.dart';
import 'attribute_list.dart';
import 'listener/listener.dart';
import 'states.dart';

class ModelAttribute<T extends Model?> extends Attribute<T> {
  ModelAttribute({
    required String name,
    required String title,
    T? dvalue,
    AttributeListener<T>? listener,
    required void Function(Attribute attribute, States state) onStateChange,
  }) : super(
          name: name,
          title: title,
          dvalue: dvalue,
          listener: listener,
          onStateChange: onStateChange,
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
    required void Function(Attribute attribute, States state) onStateChange,
  }) : super(
          name: name,
          title: title,
          dvalue: dvalue ?? [],
          listener: listener,
          onStateChange: onStateChange,
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
    required void Function(Attribute attribute, States state) onStateChange,
  }) : super(
          name: name,
          title: title,
          dvalue: dvalue,
          listener: listener,
          onStateChange: onStateChange,
        );
}

class DataModelListAttribute<T extends DataModel> extends ModelListAttribute<T> {
  DataModelListAttribute({
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
}

class DataTreeModelAttribute<T extends DataTreeModel?> extends DataModelAttribute<T> {
  DataTreeModelAttribute({
    required String name,
    required String title,
    T? dvalue,
    AttributeListener<T>? listener,
    required void Function(Attribute attribute, States state) onStateChange,
  }) : super(
          name: name,
          title: title,
          dvalue: dvalue,
          listener: listener,
          onStateChange: onStateChange,
        );
}

class DataTreeModelListAttribute<T extends DataTreeModel> extends DataModelListAttribute<T> {
  DataTreeModelListAttribute({
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
}

class SimpleModelAttribute<T extends SimpleModel?> extends ModelAttribute<T> {
  SimpleModelAttribute({
    required String name,
    required String title,
    T? dvalue,
    AttributeListener<T>? listener,
    required void Function(Attribute attribute, States state) onStateChange,
  }) : super(
          name: name,
          title: title,
          dvalue: dvalue,
          listener: listener,
          onStateChange: onStateChange,
        );
}

class SimpleModelListAttribute<T extends SimpleModel> extends ModelListAttribute<T> {
  SimpleModelListAttribute({
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
}
