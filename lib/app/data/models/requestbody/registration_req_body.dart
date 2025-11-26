import 'package:tamoily/app/data/models/register_form_response.dart';
import 'form_value.dart';

class RegistrationReqBody {
  RegistrationReqBody({
    this.data,
    this.formValues,
  });

  RegisterFormData? data;
  List<FormValue>? formValues;

  factory RegistrationReqBody.fromJson(Map<String, dynamic> json) => RegistrationReqBody(
    data: RegisterFormData.fromJson(json["Data"]),
        formValues: List<FormValue>.from(
            json["FormValues"]!.map((x) => FormValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
        "FormValues": List<dynamic>.from(formValues!.map((x) => x.toJson())),
      };
}





