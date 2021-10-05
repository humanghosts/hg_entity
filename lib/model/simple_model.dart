import 'dart:convert';
import 'dart:developer';

import '../attribute/export.dart';
import 'model.dart';

abstract class SimpleModel extends Model {
  SimpleModel();

  @override
  void clear({bool reset = false}) {
    super.clear();
    for (Attribute attr in attributes.list) {
      attr.clear(reset: reset);
    }
  }

  @override
  void merge(Model model) {
    if (runtimeType == model.runtimeType) {
      log("merge fail!this type is $runtimeType but source type is ${model.runtimeType}", level: 100);
      return;
    }
    for (Attribute attr in attributes.list) {
      Attribute? modelAttr = model.attributes.get(attr.name);
      if (null == modelAttr) return;
      attr.value = modelAttr.value;
    }
  }

  @override
  T clone<T extends Model>() {
    return json.decode(json.encode(this));
  }
}
