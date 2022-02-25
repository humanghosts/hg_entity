import 'package:hg_entity/hg_entity.dart';

abstract class SimpleModel extends Model {
  SimpleModel();

  @override
  SimpleModel clear() {
    for (Attribute attr in attributes.attributeList) {
      attr.clear();
    }
    return this;
  }

  @override
  SimpleModel merge(Model model) {
    assert(runtimeType == model.runtimeType, "类型不一致,无法合并,当前模型类型为$runtimeType,源类型为${model.runtimeType}");
    for (Attribute attr in attributes.attributeList) {
      Attribute? modelAttr = model.attributes.get(attr.name);
      if (null == modelAttr) continue;
      attr.value = modelAttr.value;
    }
    state = model.state;
    return this;
  }
}
