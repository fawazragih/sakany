
import '../get_billing_address_response.dart';
import 'form_value.dart';

class SaveBillingReqBody {
  SaveBillingReqBody({
    this.data,
    this.formValues,
  });

  SaveBillingData? data;
  List<FormValue>? formValues;

  factory SaveBillingReqBody.fromJson(Map<String, dynamic> json) => SaveBillingReqBody(
    data: json["Data"] == null ? null : SaveBillingData.fromJson(json["Data"]),
    formValues: json["FormValues"] == null ? null : List<FormValue>.from(json["FormValues"]!.map((x) => FormValue.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Data": data?.toJson(),
    "FormValues": formValues == null ? null : List<dynamic>.from(formValues!.map((x) => x.toJson())),
  };
}

class SaveBillingData {
  SaveBillingData({
    this.shipToSameAddress,
    this.billingNewAddress
  });

  bool? shipToSameAddress;
  Address?  billingNewAddress;

  factory SaveBillingData.fromJson(Map<String, dynamic> json) => SaveBillingData(
    shipToSameAddress: json["ShipToSameAddress"],
    billingNewAddress: json["BillingNewAddress"] == null ? null : Address.fromJson(json["BillingNewAddress"]),
  );

  Map<String, dynamic> toJson() => {
    "ShipToSameAddress": shipToSameAddress,
    "BillingNewAddress": billingNewAddress,
  };
}
