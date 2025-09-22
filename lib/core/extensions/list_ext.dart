extension ListExtension<T> on List<T> {
  T? firstWhereOrNull(bool Function(T element) condition) {
    if (isEmpty) return null;
    for (final element in this) {
      if (condition(element)) return element;
    }
    return null;
  }

  R? getPropertyOfFirstWhereOrNull<R>(
    bool Function(T element) condition, {
    required R Function(T element) getProperty,
  }) {
    if (isEmpty) return null;
    for (final element in this) {
      if (condition(element)) return getProperty(element);
    }
    return null;
  }
}
