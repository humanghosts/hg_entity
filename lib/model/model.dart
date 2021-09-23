import 'package:hg_entity/attribute/attribute.dart';
import 'package:hg_entity/attribute/attributes.dart';
import 'package:hg_entity/status/status.dart';

abstract class Model {
  late final Attributes attributes;
  DataStatus _status = DataStatus.none;

  Model() {
    attributes = Attributes(onStatusChange: _onStatusChange);
  }

  DataStatus get status => _status;

  void _onStatusChange(Attribute attribute, DataStatus oldStatus) {
    // attribute 和 oldStatus 暂时用不到
    DataStatus oldModelStatus = status;
    if (oldModelStatus == DataStatus.query) {
      _status = DataStatus.update;
      return;
    }
    if (oldModelStatus == DataStatus.none) {
      _status = DataStatus.insert;
    }
  }

  void markNeedRemove() {
    _status = DataStatus.delete;
  }

  void clear({bool reset = false});

  void merge(Model model);

  T clone<T extends Model>();
}
