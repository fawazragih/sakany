import 'custom_properties.dart';

class GiftCard {
  String? couponCode;
  String? amount;
  num? id;
  String? remaining;

  //
  bool? isGiftCard;
  String? recipientName;
  String? recipientEmail;
  String? senderName;
  String? senderEmail;
  String? message;
  num? giftCardType;
  CustomProperties? customProperties;

  GiftCard({
    this.couponCode,
    this.amount,
    this.id,
    this.remaining,
    this.isGiftCard,
    this.recipientName,
    this.recipientEmail,
    this.senderName,
    this.senderEmail,
    this.message,
    this.giftCardType,
    this.customProperties,
  });

  factory GiftCard.fromJson(Map<String, dynamic> json) => GiftCard(
        couponCode: json["CouponCode"],
        amount: json["Amount"],
        id: json["Id"],
        remaining: json["Remaining"],
        isGiftCard: json["IsGiftCard"],
        recipientName: json["RecipientName"],
        recipientEmail: json["RecipientEmail"],
        senderName: json["SenderName"],
        senderEmail: json["SenderEmail"],
        message: json["Message"],
        giftCardType: json["GiftCardType"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "CouponCode": couponCode,
        "Amount": amount,
        "Id": id,
        "Remaining": remaining,
        "IsGiftCard": isGiftCard,
        "RecipientName": recipientName,
        "RecipientEmail": recipientEmail,
        "SenderName": senderName,
        "SenderEmail": senderEmail,
        "Message": message,
        "GiftCardType": giftCardType,
        "CustomProperties": customProperties?.toJson(),
      };
}
