import 'dart:io';

import 'package:app_extensions/app_extensions.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class AppUser {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? fcmToken;
  String? password;

  File? imageFile;

  AppUser({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.password,
    this.fcmToken,
    this.imageFile,
  });

  String? get imageUrl =>
      image.isNullOrEmpty? null : '$image';

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
      );

  Future<Map<String, dynamic>> toJson() async => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": imageFile == null
            ? null
            : await MultipartFile.fromFile(imageFile!.path,
                contentType: MediaType(
                  'image',
                  extension(imageFile!.path).replaceAll('.', ''),
                )),
      };

  Map<String, dynamic> toLocalStorage() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": imageUrl,
      };

  Map<String, dynamic> toRegister() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
        "password": password,
        "c_password": password,
      };

  Map<String, dynamic> toLogin() => {
        'email': email,
        'password': password,
        'fcmToken': fcmToken,
      };
}
