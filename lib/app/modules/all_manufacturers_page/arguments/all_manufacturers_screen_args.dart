import 'package:app_extensions/app_extensions.dart';

class AllManufacturersScreenArgs {
  String? title;

  AllManufacturersScreenArgs({this.title});

  Map<String, String> toJson() {
    return {
      'title': title??'',
    }..removeWhere((k,v)=>v.isNullOrEmpty);
  }

  factory AllManufacturersScreenArgs.fromJson(Map<String, dynamic> json) {
    return AllManufacturersScreenArgs(
      title: json['title'],
    );
  }
}
