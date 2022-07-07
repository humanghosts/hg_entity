import 'package:hg_entity/hg_entity.dart';
import 'package:uuid/uuid.dart';

/// id生成器
abstract class IDGenerator {
  String get id;
}

/// uuid生成器
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
  static const idKey = "id";

  /// 创建时间
  late final Attribute<DateTime?> createTime;
  static const createTimeKey = "create_time";

  /// 是否删除
  late final Attribute<bool> isDelete;
  static const isDeleteKey = "is_delete";

  /// 删除时间
  late final Attribute<DateTime?> deleteTime;
  static const deleteTimeKey = "delete_time";

  /// 时间戳
  late final Attribute<DateTime> timestamp;
  static const timestampKey = "timestamp";

  /// 基本属性
  late final List<Attribute> basicAttributeList;

  DataModel() {
    id = attributes.string(name: idKey, title: "ID", dvalue: idGenerator.id);
    createTime = attributes.datetimeNullable(name: createTimeKey, title: "创建时间");
    isDelete = attributes.boolean(name: isDeleteKey, title: "是否删除", dvalue: false);
    deleteTime = attributes.datetimeNullable(name: deleteTimeKey, title: "删除时间");
    timestamp = attributes.datetime(name: timestampKey, title: "时间戳", dvalue: DateTime.now());
    basicAttributeList = [id, createTime, isDelete, deleteTime, timestamp];
  }

  IDGenerator get idGenerator => UUIDGenerator.instance;

  @override
  DataModel clear({bool reset = false, bool clearBase = false, bool Function(Attribute attr)? isClear}) {
    for (Attribute attr in attributes.attributeList) {
      if (!clearBase && basicAttributeList.contains(attr)) continue;
      if (isClear?.call(attr) ?? true) attr.clear();
    }
    return this;
  }

  @override
  DataModel merge(Model model, {bool mergeBase = false, bool Function(Attribute attr)? isClone}) {
    assert(runtimeType == model.runtimeType, "类型不一致，无法合并");
    for (Attribute attr in attributes.attributeList) {
      if (!mergeBase && basicAttributeList.contains(attr)) continue;
      if (!(isClone?.call(attr) ?? true)) continue;
      Attribute? modelAttr = model.attributes.get(attr.name);
      if (null == modelAttr) continue;
      attr.value = modelAttr.value;
    }
    state = model.state;
    return this;
  }

  @override
  String toString() {
    return id.value;
  }
}
