import 'package:flutter/material.dart';
import 'package:sqf_lite_database/sqf_lite_database/sqf_ui.dart';

void main() async {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SQLiteDemo(),
    ),
  );
}
