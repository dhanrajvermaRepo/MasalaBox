import 'dart:convert';

import 'package:get/get.dart';
import 'package:masala_box_demo/modals/cake_modal.dart';
import 'package:masala_box_demo/utils/constants.dart';
import 'package:masala_box_demo/utils/masala_box_exception.dart';
import 'package:masala_box_demo/repositories/repository.dart';

class CakeDiaryViewController extends GetxController {
  final RxBool isLoading = false.obs;
  final CakeDiaryRepository _repository = CakeDiaryRepository();
  RxList<CakeModal> cakeDiary = RxList<CakeModal>();
  String error = '';
  @override
  void onInit() {
    super.onInit();
    fetchCakeDiary();
  }

  Future<void> fetchCakeDiary({bool reset = false}) async {
    error = '';
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 1));
      final cakeList = await _repository.fetchDiary(reset);
      cakeDiary.clear();
      cakeDiary.addAll(cakeList);
      isLoading.value = false;
    } on MasalaBoxEexception catch (e) {
      error = e.message ?? '';
      isLoading.value = false;
    }
  }

  void toggleLiveStatus(CakeModal cakeModal) {
    cakeModal.toggleLiveStatus();
    final updateList = cakeDiary
        .map<Map<String, dynamic>>((element) => element.toJson())
        .toList();
    _repository.box.write(AppStrings.updatedJsonData, json.encode(updateList));
  }

  void removeCake(int position) {
    cakeDiary.removeAt(position);
    final updateList = cakeDiary
        .map<Map<String, dynamic>>((element) => element.toJson())
        .toList();
    _repository.box.write(AppStrings.updatedJsonData, json.encode(updateList));
  }
}
