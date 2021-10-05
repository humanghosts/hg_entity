import 'package:hg_entity/attribute/export.dart';

import '../model/export.dart';
import 'attribute.dart';
import 'attribute_custom.dart';
import 'attribute_list.dart';
import 'attribute_model.dart';
import 'listener.dart';

class Attributes {
  /// 名称:属性 映射
  final Map<String, Attribute> _attributeMap = {};

  late final AttributesListener? listener;

  Attributes({this.listener});

  /// 通过名称获取某个属性
  Attribute? get(String? name) => _attributeMap[name];

  /// 获取所有属性
  List<Attribute> get list => _attributeMap.values.toList();

  /// 数值字段
  Attribute<num> number({
    required String name,
    String? title,
    required num dvalue,
    AttributeListener<num>? listener,
  }) {
    Attribute<num> attr = Attribute<num>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 数值字段(值可空)
  Attribute<num?> numberNullable({
    required String name,
    String? title,
    num? dvalue,
    AttributeListener<num?>? listener,
  }) {
    Attribute<num?> attr = Attribute<num?>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 整型字段
  Attribute<int> integer({
    required String name,
    String? title,
    required int dvalue,
    AttributeListener<int>? listener,
  }) {
    Attribute<int> attr = Attribute<int>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 整型字段(值可空)
  Attribute<int?> integerNullable({
    required String name,
    String? title,
    int? dvalue,
    AttributeListener<int?>? listener,
  }) {
    Attribute<int?> attr = Attribute<int?>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 浮点型字段
  Attribute<double> float({
    required String name,
    String? title,
    required double dvalue,
    AttributeListener<double>? listener,
  }) {
    Attribute<double> attr = Attribute<double>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 浮点型字段(值可空)
  Attribute<double?> floatNullable({
    required String name,
    String? title,
    double? dvalue,
    AttributeListener<double?>? listener,
  }) {
    Attribute<double?> attr = Attribute<double?>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 字符串字段
  Attribute<String> string({
    required String name,
    String? title,
    required String dvalue,
    AttributeListener<String>? listener,
  }) {
    Attribute<String> attr = Attribute<String>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 字符串字段(值可空)
  Attribute<String?> stringNullable({
    required String name,
    String? title,
    String? dvalue,
    AttributeListener<String?>? listener,
  }) {
    Attribute<String?> attr = Attribute<String?>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 布尔字段
  Attribute<bool> boolean({
    required String name,
    String? title,
    required bool dvalue,
    AttributeListener<bool>? listener,
  }) {
    Attribute<bool> attr = Attribute<bool>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 布尔字段(值可空)
  Attribute<bool?> booleanNullable({
    required String name,
    String? title,
    bool? dvalue,
    AttributeListener<bool?>? listener,
  }) {
    Attribute<bool?> attr = Attribute<bool?>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 日期时间字段
  Attribute<DateTime> datetime({
    required String name,
    String? title,
    required DateTime dvalue,
    AttributeListener<DateTime>? listener,
  }) {
    Attribute<DateTime> attr = Attribute<DateTime>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 日期时间字段(值可空)
  Attribute<DateTime?> datetimeNullable({
    required String name,
    String? title,
    DateTime? dvalue,
    AttributeListener<DateTime?>? listener,
  }) {
    Attribute<DateTime?> attr = Attribute<DateTime?>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 数据模型字段
  DataModelAttribute<T> dataModel<T extends DataModel>({
    required String name,
    String? title,
    required T dvalue,
    AttributeListener<T>? listener,
  }) {
    DataModelAttribute<T> attr = DataModelAttribute<T>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 数据模型字段(值可空)
  DataModelAttribute<T> dataModelNullable<T extends DataModel?>({
    required String name,
    String? title,
    T? dvalue,
    AttributeListener<T>? listener,
  }) {
    DataModelAttribute<T> attr = DataModelAttribute<T>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 树形数据模型
  DataTreeModelAttribute<T> dataTreeModel<T extends DataTreeModel>({
    required String name,
    String? title,
    required T dvalue,
    AttributeListener<T>? listener,
  }) {
    DataTreeModelAttribute<T> attr = DataTreeModelAttribute<T>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 树形数据模型(值可空)
  DataTreeModelAttribute<T> dataTreeModelNullable<T extends DataTreeModel?>({
    required String name,
    String? title,
    T? dvalue,
    AttributeListener<T>? listener,
  }) {
    DataTreeModelAttribute<T> attr = DataTreeModelAttribute<T>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 简单模型
  SimpleModelAttribute<T> simpleModel<T extends SimpleModel>({
    required String name,
    String? title,
    required T dvalue,
    AttributeListener<T>? listener,
  }) {
    SimpleModelAttribute<T> attr = SimpleModelAttribute<T>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 简单模型(值可空)
  SimpleModelAttribute<T> simpleModelNullable<T extends SimpleModel?>({
    required String name,
    String? title,
    T? dvalue,
    AttributeListener<T>? listener,
  }) {
    SimpleModelAttribute<T> attr = SimpleModelAttribute<T>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 自定义
  CustomAttribute<T> custom<T extends CustomValue>({
    required String name,
    String? title,
    required T mvalue,
    required T dvalue,
    AttributeListener<T>? listener,
  }) {
    CustomAttribute<T> attr = CustomAttribute<T>(
      parent: this,
      name: name,
      title: title ?? name,
      mvalue: mvalue,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 自定义(值可空)
  CustomAttribute<T> customNullable<T extends CustomValue?>({
    required String name,
    String? title,
    required T mvalue,
    T? dvalue,
    AttributeListener<T>? listener,
  }) {
    CustomAttribute<T> attr = CustomAttribute<T>(
      parent: this,
      name: name,
      title: title ?? name,
      mvalue: mvalue,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 数值字段
  ListAttribute<num> numberList({
    required String name,
    String? title,
    List<num>? dvalue,
    ListAttributeListener<num>? listener,
  }) {
    ListAttribute<num> attr = ListAttribute<num>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 整型字段
  ListAttribute<int> integerList({
    required String name,
    String? title,
    List<int>? dvalue,
    ListAttributeListener<int>? listener,
  }) {
    ListAttribute<int> attr = ListAttribute<int>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 浮点型字段
  ListAttribute<double> floatList({
    required String name,
    String? title,
    List<double>? dvalue,
    ListAttributeListener<double>? listener,
  }) {
    ListAttribute<double> attr = ListAttribute<double>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 字符串字段
  ListAttribute<String> stringList({
    required String name,
    String? title,
    List<String>? dvalue,
    ListAttributeListener<String>? listener,
  }) {
    ListAttribute<String> attr = ListAttribute<String>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 布尔字段
  ListAttribute<bool> booleanList({
    required String name,
    String? title,
    List<bool>? dvalue,
    ListAttributeListener<bool>? listener,
  }) {
    ListAttribute<bool> attr = ListAttribute<bool>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 日期时间字段
  DateTimeListAttribute datetimeList({
    required String name,
    String? title,
    List<DateTime>? dvalue,
    ListAttributeListener<DateTime>? listener,
  }) {
    DateTimeListAttribute attr = DateTimeListAttribute(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 数据模型字段
  DataModelListAttribute<T> dataModelList<T extends DataModel>({
    required String name,
    String? title,
    List<T>? dvalue,
    ListAttributeListener<T>? listener,
  }) {
    DataModelListAttribute<T> attr = DataModelListAttribute<T>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 树形数据模型
  DataTreeModelListAttribute<T> dataTreeModelList<T extends DataTreeModel>({
    required String name,
    String? title,
    List<T>? dvalue,
    ListAttributeListener<T>? listener,
  }) {
    DataTreeModelListAttribute<T> attr = DataTreeModelListAttribute<T>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 简单模型
  SimpleModelListAttribute<T> simpleModelList<T extends SimpleModel>({
    required String name,
    String? title,
    List<T>? dvalue,
    ListAttributeListener<T>? listener,
  }) {
    SimpleModelListAttribute<T> attr = SimpleModelListAttribute<T>(
      parent: this,
      name: name,
      title: title ?? name,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 自定义数据类型
  CustomListAttribute<T> customList<T extends CustomValue>({
    required String name,
    String? title,
    required T mvalue,
    List<T>? dvalue,
    ListAttributeListener<T>? listener,
  }) {
    CustomListAttribute<T> attr = CustomListAttribute<T>(
      parent: this,
      name: name,
      title: title ?? name,
      mvalue: mvalue,
      dvalue: dvalue,
      listener: listener,
    );
    _attributeMap[name] = attr;
    return attr;
  }
}
