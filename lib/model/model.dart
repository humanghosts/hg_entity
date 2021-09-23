import 'package:hg_entity/attribute/attributes.dart';

abstract class Model {
  final Attributes attributes = Attributes();

  void clear({bool reset = false});

  void merge(Model model);

  T clone<T extends Model>();
}
