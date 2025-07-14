import 'app_user_model.dart';

class AppAuthData {
  String? token;
  AppUser? user;

  AppAuthData({
    this.token,
    this.user,
  });

  factory AppAuthData.fromJson(Map<String, dynamic> json) => AppAuthData(
        token: json["token"],
        user: json["customer"] == null
            ? null
            : AppUser.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "customer": user?.toJson(),
      };

  Map<String, dynamic> toLocalStorage() => {
        "token": token,
        "customer": user?.toLocalStorage(),
      };
}
