import '../model/export.dart';
import 'attribute.dart';
import 'attribute_list.dart';
import 'attributes.dart';
import 'listener.dart';

class ModelAttribute<T extends Model?> extends Attribute<T> {
  ModelAttribute({
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
  T initValue() {
    return dvalue?.clone() as T;
  }

  @override
  T get cvalue => value?.clone() as T;
}

class ModelListAttribute<T extends Model> extends ListAttribute<T> {
  ModelListAttribute({
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
  T initValueEach(T value) {
    return value.clone() as T;
  }

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
}

class DataModelListAttribute<T extends DataModel> extends ModelListAttribute<T> {
  DataModelListAttribute({
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
}

class DataTreeModelAttribute<T extends DataTreeModel?> extends DataModelAttribute<T> {
  DataTreeModelAttribute({
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
}

class DataTreeModelListAttribute<T extends DataTreeModel> extends DataModelListAttribute<T> {
  DataTreeModelListAttribute({
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
}

class SimpleModelAttribute<T extends SimpleModel?> extends ModelAttribute<T> {
  SimpleModelAttribute({
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
}

class SimpleModelListAttribute<T extends SimpleModel> extends ModelListAttribute<T> {
  SimpleModelListAttribute({
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
}
