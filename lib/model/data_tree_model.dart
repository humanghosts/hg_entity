import '../attribute/export.dart';
import '../util/export.dart';
import 'data_model.dart';

/// T must is a DataTreeModel
abstract class DataTreeModel<T extends DataModel> extends DataModel {
  late final Attribute<String> path;
  late final Attribute<String> fullPath;
  late final Attribute<T?> parent;
  late final ListAttribute<T> children;

  final Map<String, T> childrenMap = {};

  DataTreeModel() {
    path = attributes.string(name: "path", title: "路径", dvalue: PathUtils.genPath(length: pathLength));
    fullPath = attributes.string(name: "full_path", title: "绝对路径", dvalue: path.value);
    parent = attributes.dataModelNullable<T?>(
      name: "parent",
      title: parentTitle,
      listener: AttributeListener(beforeSetValue: beforeSetParent, afterSetValue: afterSetParent),
    );
    children = attributes.dataModelList<T>(
      name: "children",
      title: childrenTitle,
      listener: ListAttributeListener(
        beforeAddValue: beforeAddChild,
        afterAddValue: afterAddChild,
        beforeRemoveValue: beforeRemoveChild,
        afterRemoveValue: afterRemoveChild,
      ),
    );
  }

  String get parentTitle => "上级";
  String get childrenTitle => "下级";

  int get pathLength => 4;

  T? getChild(String? id) {
    return childrenMap[id];
  }

  /// 处理设置parent前 数据合法性校验，以及清空原本上级的中的自己
  bool beforeSetParent(T? parentValue) {
    // 处理重复设置Parent情况(两个都为null的情况也包含在内)
    if (parent.value == parentValue) {
      return false;
    }
    // 处理有一个为null的情况
    DataTreeModel? thisParentValue = parent.value as DataTreeModel?;
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
    // 两个对象不等，但是id相等，可以设置，替换对象就可以了
    if (parentValue.id.value == thisParentValue.id.value) {
      return true;
    }
    String parentPath = (parentValue as DataTreeModel).path.value;
    // 判断是否是否循环树
    bool isLoop = fullPath.value.contains(parentPath);
    if (isLoop) {
      throw Exception("loop tree,please check");
    }
    return true;
  }

  /// 设置上级之后设置绝对路径
  void afterSetParent(T? parentValue) {
    if (parentValue == null) {
      fullPath.value = path.value;
    } else {
      fullPath.value = "${(parentValue as DataTreeModel).fullPath.value}|${path.value}";
      parentValue.children.append(this);
    }
    // 如果当前节点有子节点
    updateChildFullPath(this);
  }

  /// 更新子节点的fullPath
  void updateChildFullPath(DataTreeModel current) {
    List children = current.children.value;
    if (children.isEmpty) {
      return;
    }
    for (int i = 0; i < children.length; i++) {
      DataTreeModel child = children[i] as DataTreeModel;
      child.fullPath.value = "${current.fullPath.value}|${child.path.value}";
      updateChildFullPath(child);
    }
  }

  bool beforeAddChild(int index, T child) {
    if (childrenMap.containsKey(child.id.value)) {
      return false;
    }
    // 这里会出发一次child的setParent，在beforeSetParent里面会进行校验
    // 在afterSetParent中会再次回到这里，然后再次进去beforeSetParent，然后判断上级一样，结束循环
    (child as DataTreeModel).parent.value = this;
    // 再次判断，因为这个代码会走两次，防止重复添加
    if (childrenMap.containsKey(child.id.value)) {
      return false;
    }
    return true;
  }

  void afterAddChild(int index, T child) {
    childrenMap[child.id.value] = child;
  }

  bool beforeRemoveChild(T child) {
    if (!childrenMap.containsKey(child.id.value)) {
      return false;
    }
    return true;
  }

  void afterRemoveChild(T child) {
    childrenMap.remove(child.id.value);
    // 这里会出发一次child的setParent，在beforeSetParent里面会进行校验
    // 会再次回到beforeRemoveChild,判断map里面已经没有了，就会结束循环
    (child as DataTreeModel).parent.value = null;
  }
}
