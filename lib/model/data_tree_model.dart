import 'package:hg_entity/attribute/attribute.dart';
import 'package:hg_entity/attribute/attribute_list.dart';
import 'package:hg_entity/attribute/listener/listener.dart';
import 'package:hg_entity/model/data_model.dart';
import 'package:hg_entity/util/path_utils.dart';

abstract class DataTreeModel extends DataModel {
  late final Attribute<String> path;
  late final Attribute<String> fullPath;
  late final Attribute<DataTreeModel?> parent;
  late final ListAttribute<DataTreeModel> children;

  final Map<String, DataTreeModel> childrenMap = {};

  DataTreeModel() {
    path = attributes.string(name: "path", title: "路径", dvalue: PathUtils.genPath(length: pathLength));
    fullPath = attributes.string(name: "full_path", title: "绝对路径", dvalue: path.value);
    parent = attributes.dataTreeModelNullable(
      name: "parent",
      title: "上级",
      listener: AttributeListener(beforeSetValue: beforeSetParent, afterSetValue: afterSetParent),
    );
    children = attributes.dataTreeModelList(
      name: "children",
      title: "下级",
      listener: ListAttributeListener(
        beforeAppendValue: beforeAppendChild,
        afterAppendValue: afterAppendChild,
        beforeRemoveValue: beforeRemoveChild,
        afterRemoveValue: afterRemoveChild,
      ),
    );
  }

  int get pathLength => 4;

  DataTreeModel? getChild(String? id) {
    return childrenMap[id];
  }

  /// 处理设置parent前 数据合法性校验，以及清空原本上级的中的自己
  bool beforeSetParent(DataTreeModel? parentValue) {
    // 处理重复设置Parent情况(两个都为null的情况也包含在内)
    if (parent.value == parentValue) {
      return false;
    }
    // 处理有一个为null的情况
    DataTreeModel? thisParentValue = parent.value;
    if (parentValue == null || thisParentValue == null) {
      // parentValue==null thisParenValue!=null
      // 清空parent
      if (thisParentValue != null) {
        // 清空上级的下级
        thisParentValue.children.remove(this);
      }
      // 另一种情况不用处理
      return true;
    }
    // 两个对象不等，但是id相等
    if (parentValue.id.value == thisParentValue.id.value) {
      return true;
    }
    String parentPath = parentValue.path.value;
    // 判断是否是否循环树
    bool isLoop = fullPath.value.contains(parentPath);
    if (isLoop) {
      throw Exception("loop tree,please check");
    }
    return true;
  }

  /// 设置上级之后设置绝对路径
  void afterSetParent(DataTreeModel? parentValue) {
    if (parentValue == null) {
      fullPath.value = path.value;
    } else {
      fullPath.value = "${parentValue.fullPath.value}|${path.value}";
      parentValue.children.append(this);
    }
  }

  bool beforeAppendChild(DataTreeModel child) {
    if (childrenMap.containsKey(child.id.value)) {
      return false;
    }
    // 这里会出发一次child的setParent，在beforeSetParent里面会进行校验
    // 在afterSetParent中会再次回到这里，然后再次进去beforeSetParent，然后判断上级一样，结束循环
    child.parent.value = this;
    return true;
  }

  void afterAppendChild(DataTreeModel child) {
    childrenMap[child.id.value] = child;
  }

  bool beforeRemoveChild(DataTreeModel child) {
    if (!childrenMap.containsKey(child.id.value)) {
      return false;
    }
    return true;
  }

  void afterRemoveChild(DataTreeModel child) {
    childrenMap.remove(child.id.value);
    // 这里会出发一次child的setParent，在beforeSetParent里面会进行校验
    // 会再次回到beforeRemoveChild,判断map里面已经没有了，就会结束循环
    child.parent.value = null;
  }
}
