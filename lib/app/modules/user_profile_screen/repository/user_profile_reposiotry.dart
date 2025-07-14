import '../../../data/models/app_user_model.dart';

class UserProfileRepository {
  UserProfileRepository._();

  static final UserProfileRepository _instance = UserProfileRepository._();

  static UserProfileRepository get instance => _instance;

  ///.......
  // final AuthApi _authApi = AuthApi();

  getUserProfile() async {
    // return await _authApi.getProfile();
  }

  updateProfile(AppUser userModel) async {
    // return await _authApi.updateProfile(userModel);
  }
}
