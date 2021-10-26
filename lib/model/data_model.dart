import 'dart:developer';

import 'package:uuid/uuid.dart';

import '../attribute/export.dart';
import 'model.dart';

abstract class IDGenerator {
  String get id;
}

class UUIDGenerator extends IDGenerator {
  UUIDGenerator._();

  static UUIDGenerator instance = UUIDGenerator._();

  static const Uuid _uuid = Uuid();

  @override
  String get id => _uuid.v1();
}

/// 基本模型
/// 规定了了基本的字段以及要实现的接口
abstract class DataModel extends Model {
  /// ID
  late final Attribute<String> id;

  /// 创建时间
  late final Attribute<DateTime?> createTime;

  /// 是否删除
  late final Attribute<bool> isDelete;

  /// 删除时间
  late final Attribute<DateTime?> deleteTime;

  /// 时间戳
  late final Attribute<DateTime> timestamp;

  /// 基本属性
  late final List<Attribute> basicAttribute;

  DataModel() {
    id = attributes.string(name: "id", title: "ID", dvalue: idGenerator.id);
    createTime = attributes.datetimeNullable(name: "create_time", title: "创建时间");
    isDelete = attributes.boolean(name: "is_delete", title: "是否删除", dvalue: false);
    deleteTime = attributes.datetimeNullable(name: "delete_time", title: "删除时间");
    timestamp = attributes.datetime(name: "timestamp", title: "时间戳", dvalue: DateTime.now());
    basicAttribute = [id, createTime, isDelete, deleteTime, timestamp];
  }

  IDGenerator get idGenerator => UUIDGenerator.instance;

  @override
  void clear({bool reset = false, bool clearBase = false}) {
    super.clear();
    for (Attribute attr in attributes.list) {
      if (!clearBase && basicAttribute.contains(attr)) continue;
      attr.clear(reset: reset);
    }
  }

  @override
  void merge(Model model, {bool mergeBase = false}) {
    if (runtimeType != model.runtimeType) {
      log("merge fail!this type is $runtimeType but source type is ${model.runtimeType}", level: 100);
      return;
    }
    for (Attribute attr in attributes.list) {
      if (!mergeBase && basicAttribute.contains(attr)) continue;
      Attribute? modelAttr = model.attributes.get(attr.name);
      if (null == modelAttr) continue;
      attr.value = modelAttr.value;
    }
  }
}
