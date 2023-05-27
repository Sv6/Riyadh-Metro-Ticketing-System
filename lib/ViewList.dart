class ViewList {
  String key;
  String value;

  ViewList(this.key, this.value);

  @override
  String toString() {
    return '{ $key, $value }';
  }
}
