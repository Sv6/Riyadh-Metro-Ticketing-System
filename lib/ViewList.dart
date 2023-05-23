class ViewList {
  String key;
  String value;

  ViewList(this.key, this.value);

  String toString() {
    return '{ ${this.key}, ${this.value} }';
  }
}
