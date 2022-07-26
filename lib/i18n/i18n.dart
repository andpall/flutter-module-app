import 'dart:convert';
import 'package:flutter/services.dart';

Future<Map> readEnJson() async {
  final String response = await rootBundle.loadString('en.json');
  final data = await json.decode(response);
  return data;
}
