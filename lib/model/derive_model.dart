import 'package:hg_entity/attribute/attribute.dart';

abstract class DeriveModel {
  Attribute get originAttribute;
  List<Attribute> get deriveAttributes;

  DeriveModel derive({int num = 1});
}
