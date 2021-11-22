import 'package:hg_entity/attribute/attribute.dart';

abstract class DeriveModel {
  /// 关联原始模型的字段，derive.origin.value == origin.derive.value
  Attribute<String> get originAttribute;

  /// 关联派生模型的字段
  Attribute<String> get deriveAttribute;

  List<DeriveModel> derive({int num = 1});
}
