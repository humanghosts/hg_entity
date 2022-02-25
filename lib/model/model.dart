import 'package:hg_entity/hg_entity.dart';

/// 模型
abstract class Model {
  /// 模型属性
  late final Attributes attributes;

  /// 模型状态
  States state = States.none;

  /// 修改过值的属性
  final Set<String> changedAttribute = {};

  Model() {
    AttributesListener listener = AttributesListener(
      onAttributeValueChange: onAttributeValueChange,
      onListAttributeValueAdd: onListAttributeValueAdd,
      onListAttributeValueRemove: onListAttributeValueRemove,
      onListAttributeValueSet: onListAttributeValueSet,
    );
    attributes = Attributes(listener: listener, model: this);
  }

  /// 监听模型属性更改并更改模型状态
  void onAttributeValueChange(Attribute attribute, Object? oldValue, Object? newValue) {
    changedAttribute.add(attribute.name);
  }

  /// 监听模型属性更改并更改模型状态
  void onListAttributeValueAdd(Attribute attribute, int index, Object? value) {
    changedAttribute.add(attribute.name);
  }

  /// 监听模型属性更改并更改模型状态
  void onListAttributeValueRemove(Attribute attribute, int index, Object? value) {
    changedAttribute.add(attribute.name);
  }

  /// 监听模型属性更改并更改模型状态
  void onListAttributeValueSet(Attribute attribute, int index, Object? value) {
    changedAttribute.add(attribute.name);
  }

  /// 清空模型
  Model clear();

  /// 合并模型
  Model merge(Model model);

  /// 复制模型
  Model clone() {
    Model newModel = ConstructorCache.get(runtimeType);
    newModel.state = state;
    for (Attribute attr in attributes.attributeList) {
      String attrName = attr.name;
      Attribute newAttr = newModel.attributes.get(attrName)!;
      newAttr.value = attr.cvalue;
    }
    return newModel;
  }
}
