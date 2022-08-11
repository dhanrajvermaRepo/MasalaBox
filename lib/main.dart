import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:masala_box_demo/cake_diary_view.dart';

void main() async {
  await GetStorage.init();
  runApp(const MasalaBoxApp());
}

class MasalaBoxApp extends StatelessWidget {
  const MasalaBoxApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CakeDiaryView(),
    );
  }
}
