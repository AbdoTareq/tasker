import 'package:tasker/export.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String toTitleCase() {
    try {
      return isEmpty
          ? this
          : replaceAll(RegExp(' +'), ' ')
              .replaceAll('_', ' ')
              .split(' ')
              .map((str) => str.capitalize())
              .join(' ');
    } catch (e) {
      Logger().i(e);
      return this;
    }
  }

  Text get text => Text(this);

  String maybeHandleOverflow({int? maxChars, String replacement = ''}) =>
      maxChars != null && length > maxChars
          ? replaceRange(maxChars, null, replacement)
          : this;
}

extension IsNullOrEmpty on String? {
  bool isNullOrEmpty() => (isNull || this!.isEmpty);
  bool get isNull => this == null || this == 'null';
  double get toDouble => double.tryParse(toString()) ?? 0.0;
  double? get toDoubleOrNull => double.tryParse(toString());
  int get toInt => int.tryParse(toString()) ?? 0;
  String orEmpty() => this ?? '';
  String orNa() => this ?? 'N/A';
  String orDash() => this ?? '-';
}
