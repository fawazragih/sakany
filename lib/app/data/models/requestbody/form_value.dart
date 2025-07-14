import 'package:file_picker/file_picker.dart';

class FormValue {
  FormValue({
    this.key,
    this.value,
    this.file,
  });

  String? key;
  String? value;

  FilePickerResult? file;

  factory FormValue.fromJson(Map<String, dynamic> json) => FormValue(
        key: json["Key"],
        value: json["Value"],
      );

  Map<String, dynamic> toJson() => {
        "Key": key,
        "Value": value,
      };
}
