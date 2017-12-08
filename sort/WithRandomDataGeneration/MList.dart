library MyList;

import 'dart:collection';

class _SubMList<E> extends Object with ListMixin<E> {
  final List<E> _source;
  final int _offset;
  final int _length;

  _SubMList(this._source, int offset, int fromIndex, int toIndex)
      : this._offset = offset + fromIndex,
        this._length = toIndex - fromIndex;

  E operator [](int index) => _source[_offset + index];
  operator []=(int index, E value) => _source[_offset + index] = value;

  int get length => _length;
  set length(int length) => throw new UnsupportedError("length=");

  List<E> subList(int fromIndex, [int toIndex]) {
    int end = RangeError.checkValidRange(fromIndex, toIndex, _length);
    return new _SubMList(_source, _offset, fromIndex, end);
  }
}

class MList<E> extends Object with ListMixin<E> implements List<E> {
  List<E> _source;
  MList.from(List<E> elements) {
    _source = new List<E>(elements.length);
    for (int i = 0; i < elements.length; i++) {
      _source[i] = elements[i];
    }
  }

  E operator [](int index) => _source[index];
  operator []=(int index, E value) => _source[index] = value;

  int get length => _source.length;
  set length(int length) => throw new UnsupportedError("length=");

  /// return sublist backed by origin list.
  List<E> subList(int fromIndex, [int toIndex]) {
    int length = RangeError.checkValidRange(fromIndex, toIndex, this.length);
    return new _SubMList(_source, 0, fromIndex, length);
  }

  String toString() {
    return _source.toString();
  }
}
