
import 'custom_properties.dart';

class BasCheckoutPaymentInfo {
    BasCheckoutPaymentInfoData? data;
    dynamic message;
    List<dynamic>? errorList;

    BasCheckoutPaymentInfo({
        this.data,
        this.message,
        this.errorList,
    });

    factory BasCheckoutPaymentInfo.fromJson(Map<String, dynamic> json) => BasCheckoutPaymentInfo(
        data: json["Data"] == null ? null : BasCheckoutPaymentInfoData.fromJson(json["Data"]),
        message: json["Message"],
        errorList: json["ErrorList"] == null ? [] : List<dynamic>.from(json["ErrorList"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
        "Message": message,
        "ErrorList": errorList == null ? [] : List<dynamic>.from(errorList!.map((x) => x)),
    };
}

class BasCheckoutPaymentInfoData {
    bool? termsOfServiceOnOrderConfirmPage;
    bool? termsOfServicePopup;
    dynamic minOrderTotalWarning;
    List<dynamic>? warnings;
    CustomProperties? customProperties;

    BasCheckoutPaymentInfoData({
        this.termsOfServiceOnOrderConfirmPage,
        this.termsOfServicePopup,
        this.minOrderTotalWarning,
        this.warnings,
        this.customProperties,
    });

    factory BasCheckoutPaymentInfoData.fromJson(Map<String, dynamic> json) => BasCheckoutPaymentInfoData(
        termsOfServiceOnOrderConfirmPage: json["TermsOfServiceOnOrderConfirmPage"],
        termsOfServicePopup: json["TermsOfServicePopup"],
        minOrderTotalWarning: json["MinOrderTotalWarning"],
        warnings: json["Warnings"] == null ? [] : List<dynamic>.from(json["Warnings"]!.map((x) => x)),
        customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
    );

    Map<String, dynamic> toJson() => {
        "TermsOfServiceOnOrderConfirmPage": termsOfServiceOnOrderConfirmPage,
        "TermsOfServicePopup": termsOfServicePopup,
        "MinOrderTotalWarning": minOrderTotalWarning,
        "Warnings": warnings == null ? [] : List<dynamic>.from(warnings!.map((x) => x)),
        "CustomProperties": customProperties?.toJson(),
    };
}

// class CustomProperties {
//     CustomProperties();
//
//     factory CustomProperties.fromJson(Map<String, dynamic> json) => CustomProperties(
//     );
//
//     Map<String, dynamic> toJson() => {
//     };
// }
