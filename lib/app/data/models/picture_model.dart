import 'custom_properties.dart';

class PictureModel {
  PictureModel({
    this.imageUrl,
    this.thumbImageUrl,
    this.fullSizeImageUrl,
    this.title,
    this.alternateText,
    this.customProperties,
  });

  String? imageUrl;
  String? thumbImageUrl;
  String? fullSizeImageUrl;
  String? title;
  String? alternateText;
  CustomProperties? customProperties;

  factory PictureModel.fromJson(Map<String, dynamic> json) {
    return PictureModel(
      imageUrl: json["ImageUrl"],
      thumbImageUrl: json["ThumbImageUrl"],
      fullSizeImageUrl: json["FullSizeImageUrl"],
      title: json["Title"],
      alternateText: json["AlternateText"],
      customProperties: json["CustomProperties"] == null
          ? null
          : CustomProperties.fromJson(json["CustomProperties"]),
    );
  }

  factory PictureModel.fake() {
    return PictureModel(
      imageUrl: "https://via.placeholder.com/600x400.png",
      thumbImageUrl: "https://via.placeholder.com/150x150.png",
      fullSizeImageUrl: "https://via.placeholder.com/600x400.png",
      title: "Picture Title",
      alternateText: "Picture Alternate Text",
      customProperties: CustomProperties.fake(),
    );
  }

  Map<String, dynamic> toJson() => {
        "ImageUrl": imageUrl,
        "ThumbImageUrl": thumbImageUrl,
        "FullSizeImageUrl": fullSizeImageUrl,
        "Title": title,
        "AlternateText": alternateText,
        "CustomProperties": customProperties?.toJson(),
      };
}
