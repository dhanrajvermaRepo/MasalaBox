import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:masala_box_demo/cake_diary_view_controller.dart';
import 'package:masala_box_demo/cake_modal.dart';
import 'package:masala_box_demo/constants.dart';
import 'package:get/get.dart';

import 'app_text_styles.dart';

class CakeListItem extends StatelessWidget {
  CakeListItem({Key? key, required this.cakeModal, required this.onDelete})
      : super(key: key);
  final CakeModal cakeModal;
  final VoidCallback onDelete;
  final CakeDiaryViewController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.cake,
                      color: Colors.green,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      cakeModal.cakeName,
                      style: AppTextStyle.titleStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  cakeModal.description,
                  style: AppTextStyle.bodyTextStyle,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "₹${cakeModal.price}",
                  style: AppTextStyle.titleStyle.copyWith(color: Colors.orange),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 100,
                width: 70,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.5)),
                child: CachedNetworkImage(
                  imageUrl: cakeModal.cakeImage,
                  fit: BoxFit.cover,
                  placeholder: (_, __) {
                    return Image.asset(
                      AppStrings.cakePlaceHolder,
                      fit: BoxFit.contain,
                    );
                  },
                  errorWidget: (_, ___, ____) {
                    return Image.asset(
                      AppStrings.cakePlaceHolder,
                      fit: BoxFit.contain,
                    );
                  },
                ),
              ),
              Obx(() {
                return MasalaSwitch(
                  value: cakeModal.isLive.value,
                  onChange: () {
                    _controller.toggleLiveStatus(cakeModal);
                  },
                );
              })
            ],
          ),
        ],
      ),
    );
  }
}

class MasalaSwitch extends StatelessWidget {
  const MasalaSwitch({Key? key, required this.value, required this.onChange})
      : super(key: key);
  final bool value;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChange,
      child: Container(
        padding: const EdgeInsets.all(3),
        height: 20,
        width: 60,
        decoration: BoxDecoration(
          color: value ? Colors.green : Colors.grey,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              value ? "LIVE" : "OFF",
              style: AppTextStyle.titleStyle
                  .copyWith(color: Colors.white, fontSize: 9),
            ),
            AnimatedPositioned(
              right: value ? 0 : 40,
              child: Container(
                height: 12,
                width: 12,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
            )
          ],
        ),
      ),
    );
  }
}
