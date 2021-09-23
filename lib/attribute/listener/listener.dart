class AttributeListener<T> {
  bool Function(T value)? beforeSetValue;
  void Function(T value)? afterSetValue;

  AttributeListener({this.beforeSetValue, this.afterSetValue});
}

class ListAttributeListener<T> extends AttributeListener<List<T>> {
  bool Function(T value)? beforeAppendValue;
  void Function(T value)? afterAppendValue;
  bool Function(T value)? beforeRemoveValue;
  void Function(T value)? afterRemoveValue;

  ListAttributeListener({
    bool Function(List<T> value)? beforeSetValue,
    void Function(List<T> value)? afterSetValue,
    this.beforeAppendValue,
    this.afterAppendValue,
    this.beforeRemoveValue,
    this.afterRemoveValue,
  }) : super(beforeSetValue: beforeSetValue, afterSetValue: afterSetValue);
}
