import 'package:sakani/app/data/models/estimate_shipping.dart';
import 'package:sakani/app/data/models/requestbody/form_value.dart';

class EstimateShippingReqBody {
  EstimateShippingReqBody({
    this.data,
    this.formValues,
  });

  EstimateShipping? data;
  List<FormValue>? formValues;

  factory EstimateShippingReqBody.fromJson(Map<String, dynamic> json) =>
      EstimateShippingReqBody(
        data: json["Data"] == null ? null : EstimateShipping.fromJson(json["Data"]),
        formValues: json["FormValues"] == null
            ? null
            : List<FormValue>.from(
                json["FormValues"]!.map((x) => FormValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
        "FormValues": formValues == null
            ? null
            : List<dynamic>.from(formValues!.map((x) => x.toJson())),
      };
}
