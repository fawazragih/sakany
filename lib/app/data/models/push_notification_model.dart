// To parse this JSON data, do
//
//     final pushNotificationModel = pushNotificationModelFromJson(jsonString);


import 'package:collection/collection.dart';

// PushNotificationModel pushNotificationModelFromJson(String str) => PushNotificationModel.fromJson(json.decode(str));

// String? pushNotificationModelToJson(PushNotificationModel data) => json.encode(data.toJson());

enum NotificationType {
  NONE(0),
  PRODUCT(10),
  CATEGORY(20),
  MANUFACTURER(30),
  VENDOR(40),
  ORDER(40),
  TOPIC(60),
  ACCOUNT(70),

  // local notification
  FILE_DOWNLOADED(1001);

  final int value;

  const NotificationType(this.value);
}

class PushNotificationModel {
  PushNotificationModel({
    this.notificationForeground,
    this.title,
    this.body,
    this.itemType,
    this.itemId,
    this.bigPicture,
  });

  String? notificationForeground;
  String? title;
  String? body;
  NotificationType? itemType;
  String? itemId;
  String? bigPicture;

  factory PushNotificationModel.fromJson(Map<String, dynamic> json) =>
      PushNotificationModel(
        notificationForeground: json["notification_foreground"],
        title: json["title"],
        body: json["body"],
        itemType: NotificationType.values.firstWhereOrNull(
            (e) => e.value == int.tryParse(json["itemType"]?.toString() ?? '')),
        itemId: json["itemId"],
        bigPicture: json["bigPicture"],
      );

  Map<String, dynamic> toJson() => {
        "notification_foreground": notificationForeground,
        "title": title,
        "body": body,
        "itemType": itemType,
        "itemId": itemId,
        "bigPicture": bigPicture,
      };
}
