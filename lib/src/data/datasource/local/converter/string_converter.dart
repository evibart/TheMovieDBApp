import 'dart:convert';

import 'package:floor/floor.dart';

class StringListConverter extends TypeConverter<List<String>, String> {
  @override
  List<String> decode(String databaseValue) {
    final List<dynamic> parsedList = json.decode(databaseValue);
    return parsedList.cast<String>();
  }

  @override
  String encode(List<String> value) {
    return json.encode(value);
  }
}
