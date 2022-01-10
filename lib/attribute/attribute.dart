import 'dart:convert';

import 'package:hg_entity/hg_entity.dart';

class Attribute<T> {
  /// 字段值
  late T _value;

  /// 字段默认值
  final T? dvalue;

  /// 字段名称
  final String name;

  /// 字段标题
  late String title;

  /// 字段注释
  late String? comment;

  /// 监听器 {id:listener}
  late final Map<String, AttributeListener<T>> listenerMap;

  /// 所有属性集合
  final Attributes parent;

  /// 构造方法:
  /// [parent] 创造attribute的Attributes
  /// [name] 属性的名称，相当于map中的key
  /// [title] 属性的别名
  /// [comment] 对于属性的注释
  /// [value] 属性的初始值=
  /// [dvalue] 非空属性的默认值
  /// [listenerMap] 属性set和get时候通知的监听器
  Attribute({
    required this.parent,
    required this.name,
    String? title,
    this.comment,
    T? value,
    this.dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    // 设置别名
    this.title = title ?? name;
    // 设置监听器
    this.listenerMap = listenerMap ?? {};
    // 设置初始值
    initValue(value);
  }

  /// 初始化值
  void initValue(T? value, {bool isInit = true}) {
    // 是否为可空类型
    bool isNullable = type.toString().endsWith("?");
    // 非空类型并且value为空，使用dvalue赋值
    if (null == value && !isNullable) {
      assert(dvalue != null, "$name属性类型非空，必须有值或者默认值}");
      if (isInit) {
        _value = getDefaultValue();
      } else {
        this.value = getDefaultValue();
      }
    } else {
      if (isInit) {
        _value = value as T;
      } else {
        this.value = value as T;
      }
    }
  }

  /// 获取默认值
  T getDefaultValue() => json.decode(json.encode(dvalue)) as T;

  /// 获取字段值
  T get value => _value;

  /// 获取字段值类型
  Type get type => T;

  /// 获取值是否为空
  bool get isNull => value == null;

  /// 获取值拷贝
  T get cvalue {
    if (isNull) {
      return null as T;
    }
    return json.decode(json.encode(value));
  }

  /// 设置字段值
  set value(T value) {
    // 监听列表
    Map<String, AttributeListener<T>> listenerMap = this.listenerMap;
    // 旧值
    T oldValue = this.value;
    // 监听器为空，直接修改值
    if (listenerMap.isEmpty) {
      _value = value;
      parent.listener?.onAttributeValueChange?.call(this, oldValue, this.value);
      return;
    }
    // 遍历监听器，调用beforeSetValue
    for (AttributeListener<T> listener in listenerMap.values) {
      bool Function(T value)? beforeSetValue = listener.beforeSetValue;
      // 如果不可以修改，直接返回即可
      if (beforeSetValue != null && !beforeSetValue(value)) {
        return;
      }
    }
    // 设置值
    _value = value;
    // 遍历监听器，调用afterSetValue
    for (AttributeListener<T> listener in listenerMap.values) {
      listener.afterSetValue?.call(value);
    }
    // 调用父监听器，监听值的修改
    parent.listener?.onAttributeValueChange?.call(this, oldValue, this.value);
  }

  /// 设置不限制类型的值，容易报错，慎用
  set valueTypeless(dynamic value) {
    this.value = value as T;
  }

  /// 清空值，如果是非空类型，设置值为默认值
  Attribute<T> clear() {
    // 旧值
    T oldValue = value;
    // 重新初始化值
    initValue(null, isInit: false);
    // 调用父监听器，监听值的修改
    parent.listener?.onAttributeValueChange?.call(this, oldValue, value);
    return this;
  }

  /// 添加监听器
  Attribute<T> addListener(String key, AttributeListener<T> listener) {
    listenerMap[key] = listener;
    return this;
  }

  /// 移除指定监听器
  Attribute<T> removeListener(String key) {
    listenerMap.remove(key);
    return this;
  }

  /// 移除所有监听器
  Attribute<T> removeAllListener() {
    listenerMap.clear();
    return this;
  }

  @override
  String toString() {
    return {
      "name": name,
      "value": value,
      "title": title,
      "comment": comment,
      "type": type,
      "dvalue": dvalue,
    }.toString();
  }
}

/// 列表类型的属性
class ListAttribute<T> extends Attribute<List<T>> {
  ListAttribute({
    required Attributes parent,
    required String name,
    String? title,
    String? comment,
    List<T>? value,
    List<T>? dvalue,
    Map<String, ListAttributeListener<T>>? listenerMap,
  }) : super(
          parent: parent,
          name: name,
          title: title,
          comment: comment,
          value: value,
          dvalue: dvalue ?? [],
          listenerMap: listenerMap,
        );

  @override
  List<T> getDefaultValue() => dvalue?.map((e) => json.decode(json.encode(e)) as T).toList() as List<T>;

  /// 属性类型,List内的泛型
  @override
  Type get type => T;

  @override
  bool get isNull => value.isEmpty;

  @override
  List<T> get cvalue {
    if (isNull) return [];
    return value.map((e) => json.decode(json.encode(e)) as T).toList();
  }

  @override
  set valueTypeless(dynamic value) {
    this.value = (value as List).map((e) => e as T).toList();
  }

  /// 添加一个值
  ListAttribute<T> append(T value) {
    insert(this.value.length, value);
    return this;
  }

  /// 添加一系列值
  ListAttribute<T> appendAll(List<T> valueList) {
    for (T value in valueList) {
      append(value);
    }
    return this;
  }

  /// 删除一个值
  ListAttribute<T> remove(T value) {
    if (null == value) {
      return this;
    }
    Map<String, AttributeListener<List<T>>> listenerMap = this.listenerMap;
    if (listenerMap.isEmpty) {
      this.value.remove(value);
      parent.listener?.onListAttributeValueRemove?.call(this, value);
      return this;
    }
    // 只要有一个不允许设置值，返回
    for (AttributeListener<List<T>> listener in listenerMap.values) {
      if (listener is! ListAttributeListener<T>) continue;
      Function(T value)? beforeRemoveValue = listener.beforeRemoveValue;
      if (null != beforeRemoveValue && !beforeRemoveValue(value)) {
        return this;
      }
    }
    // 移除值
    this.value.remove(value);
    for (AttributeListener<List<T>> listener in listenerMap.values) {
      if (listener is! ListAttributeListener<T>) continue;
      listener.afterRemoveValue?.call(value);
    }
    parent.listener?.onListAttributeValueRemove?.call(this, value);
    return this;
  }

  /// 删除指定位置的值
  ListAttribute removeAt(int index) {
    if (index >= this.value.length) {
      return this;
    }
    T value = this.value[index];
    remove(value);
    return this;
  }

  /// 删除所有值
  ListAttribute removeAll(List<T> valueList) {
    for (T value in valueList) {
      remove(value);
    }
    return this;
  }

  /// 在指定位置插入值
  ListAttribute insert(int index, T value) {
    if (null == value || index > this.value.length || index < 0) {
      return this;
    }
    Map<String, AttributeListener<List<T>>> listenerMap = this.listenerMap;
    if (listenerMap.isEmpty) {
      this.value.insert(index, value);
      parent.listener?.onListAttributeValueAdd?.call(this, index, value);
      return this;
    }
    for (AttributeListener<List<T>> listener in listenerMap.values) {
      if (listener is! ListAttributeListener<T>) continue;
      Function(int index, T value)? beforeAppendValue = listener.beforeAddValue;
      if (null != beforeAppendValue && !beforeAppendValue(index, value)) {
        return this;
      }
    }
    this.value.insert(index, value);
    for (AttributeListener<List<T>> listener in listenerMap.values) {
      if (listener is! ListAttributeListener<T>) continue;
      listener.afterAddValue?.call(index, value);
    }
    parent.listener?.onListAttributeValueAdd?.call(this, index, value);
    return this;
  }

  @override
  ListAttribute<T> clear() {
    List<T> allValue = [...value];
    removeAll(allValue);
    return this;
  }
}
