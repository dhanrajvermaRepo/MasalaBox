import 'package:get/get.dart';

class CakeModal {
  CakeModal(
      {required this.cakeImage,
      required this.cakeName,
      required this.description,
      required this.isVeg,
      required this.price,
      required bool liveStatus})
      : _isLive = RxBool(liveStatus);
  final String cakeImage;
  final int price;
  final bool isVeg;
  final String cakeName;
  final String description;
  final RxBool _isLive;
  RxBool get isLive => _isLive;

  factory CakeModal.fromJson(Map<String, dynamic> data) {
    return CakeModal(
        cakeImage: data["image"] ?? '',
        cakeName: data['name'] ?? '',
        description: data['description'] ?? '',
        isVeg: data['isVeg'] ?? false,
        price: data['price'] ?? 0,
        liveStatus: data['isLive'] ?? false);
  }
  Map<String, dynamic> toJson() {
    return {
      "image": cakeImage,
      "name": cakeName,
      "description": description,
      "isVeg": isVeg,
      "price": price,
      "isLive": _isLive.value,
    };
  }

  void toggleLiveStatus() {
    _isLive.value = !_isLive.value;
  }
}
