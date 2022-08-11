import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:masala_box_demo/modals/cake_modal.dart';
import 'package:masala_box_demo/utils/constants.dart';
import 'package:masala_box_demo/utils/masala_box_exception.dart';
import 'package:get_storage/get_storage.dart';

class CakeDiaryRepository {
  final box = GetStorage();
  Future<List<CakeModal>> fetchDiary(bool reset) async {
    try {
      late final String response;
      if (reset) {
        box.remove(AppStrings.updatedJsonData);
        response = await rootBundle.loadString(AppStrings.jsonDataSet);
      } else {
        response = box.read<String>(AppStrings.updatedJsonData) ??
            (await rootBundle.loadString(AppStrings.jsonDataSet));
      }
      final data = await json.decode(response) as List<dynamic>;
      return data.map<CakeModal>((e) => CakeModal.fromJson(e)).toList();
    } catch (e) {
      throw MasalaBoxEexception(message: e.toString(), errorCode: 404);
    }
  }
}
