import '../attribute/export.dart';
import '../context/cache.dart';

abstract class Model {
  late final Attributes attributes;
  States state = States.none;

  Model() {
    AttributesListener listener = AttributesListener(
      onAttributeValueChange: onAttributeValueChange,
      onListAttributeValueAdd: onListAttributeValueAdd,
      onListAttributeValueRemove: onListAttributeValueRemove,
    );
    attributes = Attributes(listener: listener);
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

  void onListAttributeValueAdd(Attribute attribute, Object value) {
    _changeState();
  }

  void onListAttributeValueRemove(Attribute attribute, Object value) {
    _changeState();
  }

  void clear({bool reset = false}) {
    state = States.none;
  }

  void merge(Model model);

  T clone<T extends Model>() {
    T newModel = ModelInitCache.get(runtimeType);
    for (Attribute attr in attributes.list) {
      String attrName = attr.name;
      Attribute newAttr = newModel.attributes.get(attrName)!;
      newAttr.value = attr.cvalue;
    }
    return newModel;
  }
}
