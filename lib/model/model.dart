import 'package:hg_entity/hg_entity.dart';

abstract class Model {
  late final Attributes attributes;
  States state = States.none;

  Model() {
    AttributesListener listener = AttributesListener(
      onAttributeValueChange: onAttributeValueChange,
      onListAttributeValueAdd: onListAttributeValueAdd,
      onListAttributeValueRemove: onListAttributeValueRemove,
    );
    attributes = Attributes(listener: listener, model: this);
  }

  void _changeState() {
    States oldModelState = state;
    if (oldModelState == States.query) {
      state = States.update;
    }
    if (oldModelState == States.none) {
      state = States.insert;
    }
  }

  void onAttributeValueChange(Attribute attribute, Object? oldValue, Object? newValue) {
    _changeState();
  }

  void onListAttributeValueAdd(Attribute attribute, int index, Object value) {
    _changeState();
  }

  void onListAttributeValueRemove(Attribute attribute, Object value) {
    _changeState();
  }

  Model clear() {
    state = States.none;
    return this;
  }

  Model merge(Model model);

  Model clone() {
    Model newModel = ConstructorCache.get(runtimeType);
    for (Attribute attr in attributes.list) {
      String attrName = attr.name;
      Attribute newAttr = newModel.attributes.get(attrName)!;
      newAttr.value = attr.cvalue;
    }
    return newModel;
  }
}
