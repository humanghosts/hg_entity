import '../attribute/export.dart';
import 'model.dart';

abstract class SimpleModel extends Model {
  SimpleModel();

  @override
  SimpleModel clear({bool reset = false}) {
    super.clear();
    for (Attribute attr in attributes.list) {
      attr.clear(reset: reset);
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
