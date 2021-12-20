import 'package:hg_entity/hg_entity.dart';

abstract class SimpleModel extends Model {
  SimpleModel();

  @override
  SimpleModel clear() {
    super.clear();
    for (Attribute attr in attributes.list) {
      attr.clear();
    }
    return this;
  }

  @override
  SimpleModel merge(Model model) {
    assert(runtimeType == model.runtimeType, "merge fail!this type is $runtimeType but source type is ${model.runtimeType}");
    for (Attribute attr in attributes.list) {
      Attribute? modelAttr = model.attributes.get(attr.name);
      if (null == modelAttr) continue;
      attr.value = modelAttr.value;
    }
    return this;
  }
}
