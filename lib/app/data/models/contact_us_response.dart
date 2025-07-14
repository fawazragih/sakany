
import 'custom_properties.dart';

class ContactUsResponse {
  ContactUsResponse({
    this.data,
    this.message,
    this.errorList,
  });

  ContactUsData? data;
  String?  message;
  List<String>? errorList;

  factory ContactUsResponse.fromJson(Map<String, dynamic> json) => ContactUsResponse(
    data: json["Data"] == null ? null : ContactUsData.fromJson(json["Data"]),
    message: json["Message"],
    errorList: json["ErrorList"] == null ? null : List<String>.from(json["ErrorList"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Data": data?.toJson(),
    "Message": message,
    "ErrorList": errorList == null ? null : List<dynamic>.from(errorList!.map((x) => x)),
  };
}

class ContactUsData {
  ContactUsData({
    this.email,
    this.subject,
    this.subjectEnabled,
    this.enquiry,
    this.fullName,
    this.successfullySent,
    this.result,
    this.displayCaptcha,
    this.customProperties,
  });

  String?  email;
  String?  subject;
  bool? subjectEnabled;
  String?  enquiry;
  String?  fullName;
  bool? successfullySent;
  dynamic result;
  bool? displayCaptcha;
  CustomProperties?  customProperties;

  factory ContactUsData.fromJson(Map<String, dynamic> json) => ContactUsData(
    email: json["Email"],
    subject: json["Subject"],
    subjectEnabled: json["SubjectEnabled"],
    enquiry: json["Enquiry"],
    fullName: json["FullName"],
    successfullySent: json["SuccessfullySent"],
    result: json["Result"],
    displayCaptcha: json["DisplayCaptcha"],
    customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Email": email,
    "Subject": subject,
    "SubjectEnabled": subjectEnabled,
    "Enquiry": enquiry,
    "FullName": fullName,
    "SuccessfullySent": successfullySent,
    "Result": result,
    "DisplayCaptcha": displayCaptcha,
    "CustomProperties": customProperties?.toJson(),
  };
}