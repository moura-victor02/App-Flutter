import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './home_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [GetPage(name: '/', page: () => Homepage())],
    );
  }
}
