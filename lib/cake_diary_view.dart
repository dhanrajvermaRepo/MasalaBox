import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:masala_box_demo/cake_diary_view_controller.dart';
import 'package:masala_box_demo/cake_list_item.dart';
import 'package:masala_box_demo/constants.dart';
import 'package:get/get.dart';

import 'app_text_styles.dart';

class CakeDiaryView extends StatelessWidget {
  CakeDiaryView({Key? key}) : super(key: key);
  final CakeDiaryViewController _controller =
      Get.put(CakeDiaryViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(AppStrings.cakeDiary, style: AppTextStyle.titleStyle),
        centerTitle: false,
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (_controller.error.isNotEmpty) {
          return Center(
            child: Text(
              _controller.error,
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            _controller.fetchCakeDiary(reset: true);
          },
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            }),
            child: ListView.builder(
              itemBuilder: (_, int index) {
                final cake = _controller.cakeDiary[index];
                return CakeListItem(
                  cakeModal: cake,
                  onDelete: () {
                    _controller.removeCake(index);
                  },
                );
              },
              itemCount: _controller.cakeDiary.length,
            ),
          ),
        );
      }),
    );
  }
}
