import 'package:app_extensions/app_extensions.dart';

class HomeSliderResponse {
  HomeSliderResponse({
    this.data,
    this.message,
    this.errorList,
  });

  HomeSliderData? data;
  String? message;
  List<String>? errorList;

  factory HomeSliderResponse.fromJson(Map<String, dynamic> json) =>
      HomeSliderResponse(
        data:
            json["Data"] == null ? null : HomeSliderData.fromJson(json["Data"]),
        message: json["Message"],
        errorList: json["ErrorList"] == null
            ? null
            : List<String>.from(json["ErrorList"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
        "Message": message,
        "ErrorList": errorList == null
            ? null
            : List<String>.from(errorList!.map((x) => x)),
      };
}

class HomeSliderData {
  HomeSliderData({
    this.isEnabled,
    this.sliders,
  });

  bool? isEnabled;
  List<Sliders>? sliders;

  factory HomeSliderData.fromJson(Map<String, dynamic> json) => HomeSliderData(
        isEnabled: json["IsEnabled"],
        sliders: json["Sliders"] == null
            ? null
            : List<Sliders>.from(
                json["Sliders"]!.map((x) => Sliders.fromJson(x))),
      );

  factory HomeSliderData.fake() => HomeSliderData(
        isEnabled: true,
        sliders: List<Sliders>.generate(3, (index) => Sliders.fake()),
      );

  Map<String, dynamic> toJson() => {
        "IsEnabled": isEnabled,
        "Sliders": sliders == null
            ? null
            : List<dynamic>.from(sliders!.map((x) => x.toJson())),
      };
}

enum SliderType {
  product(10),
  category(20),
  manufacturer(30),
  vendor(40),
  topic(50);

  final int value;

  const SliderType(this.value);
}

class Sliders {
  Sliders({
    this.imageUrl,
    this.sliderType,
    this.entityId,
    this.id,
  });

  String? imageUrl;
  SliderType? sliderType;
  int? entityId;
  int? id;

  factory Sliders.fromJson(Map<String, dynamic> json) => Sliders(
        imageUrl: json["ImageUrl"],
        sliderType: SliderType.values.firstWhereOrNULL(
            (e) => e.value == int.tryParse(json["SliderType"].toString())),
        entityId: json["EntityId"],
        id: json["Id"],
      );

  factory Sliders.fake() => Sliders(
        imageUrl: "https://via.placeholder.com/150",
      );

  Map<String, dynamic> toJson() => {
        "ImageUrl": imageUrl,
        "SliderType": sliderType,
        "EntityId": entityId,
        "Id": id,
      };
}
