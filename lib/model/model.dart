import '../attribute/export.dart';

abstract class Model {
  late final Attributes attributes;
  States _state = States.none;

  Model() {
    attributes = Attributes(onStateChange: _onStateChange);
  }

  States get state => _state;

  void _onStateChange(Attribute attribute, States oldState) {
    // attribute 和 oldState 暂时用不到
    States oldModelState = state;
    if (oldModelState == States.query) {
      _state = States.update;
      return;
    }
    if (oldModelState == States.none) {
      _state = States.insert;
    }
  }

  void markNeedRemove() {
    _state = States.delete;
  }

  void clear({bool reset = false});

  void merge(Model model);

  T clone<T extends Model>();
}
