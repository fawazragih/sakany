import 'base_configs/base_api.dart';

class ForgetAndRestPasswordApi extends BaseApi {
  restPassword(String idNumber, String phoneNumber) async {
    // try {
    //   var response = await dioWithOutToken.post(
    //     ApiPaths.resetPassword,
    //   );
    //
    //   dynamic data = response.data;
    //
    //   var decodedJsonData = jsonDecode(jsonEncode(data));
    //   logger.d(decodedJsonData);
    //
    //   if (response.statusCode == 200 &&
    //       decodedJsonData != null &&
    //       decodedJsonData is int) {
    //     return decodedJsonData;
    //   } else {
    //     return decodedJsonData.toString();
    //   }
    // } on DioError catch (error) {
    //   logger.d('--catch error in sendForgetPasswordCode --');
    //   logger.d(error.response?.data?.toString());
    //   logger.d(error.message.toString());
    //   if (error.response?.data != null) {
    //     return error.response?.data.toString();
    //   }
    //   return error.message;
    // }
  }

  generateNewPassword(String snlNumber, String passwordCode) async {
    // try {
    //   var response = await dioWithOutToken.post(
    //     ApiPaths.generateNewPassword,
    //     data: {
    //       "snlNumber": snlNumber,
    //       "passwordCode": passwordCode,
    //     },
    //     options: Options(
    //       headers: {
    //         Headers.contentTypeHeader: Headers.formUrlEncodedContentType,
    //       },
    //     ),
    //   );
    //
    //   dynamic data = response.data;
    //
    //   var decodedJsonData = jsonDecode(jsonEncode(data));
    //   logger.d(decodedJsonData);
    //
    //   if (response.statusCode == 200
    //       // &&
    //       // decodedJsonData != null &&
    //       // decodedJsonData is int
    //       ) {
    //     return true;
    //   } else {
    //     return decodedJsonData.toString();
    //   }
    // } on DioError catch (error) {
    //   logger.d('--catch error in generateNewPassword --');
    //   logger.d(error.response?.data?.toString());
    //   logger.d(error.message.toString());
    //   if (error.response?.data != null) {
    //     return error.response?.data.toString();
    //   }
    //   return error.message;
    // }
  }

  changePassword(String newPassword, String confirmPassword) async {
    // try {
    //   var response = await dio.post(
    //     ApiPaths.changePassword,
    //     data: {
    //       "newPassword": newPassword,
    //       "confirmPassword": confirmPassword,
    //     },
    //     // options: Options(
    //     //   headers: {
    //     //     Headers.contentTypeHeader: Headers.formUrlEncodedContentType,
    //     //   },
    //     // ),
    //   );
    //
    //   dynamic data = response.data;
    //
    //   var decodedJsonData = jsonDecode(jsonEncode(data));
    //   logger.d(decodedJsonData);
    //
    //   if (response.statusCode == 200) {
    //     return true;
    //   } else {
    //     return decodedJsonData.toString();
    //   }
    // } on DioError catch (error) {
    //   logger.d('--catch error in changePassword --');
    //   logger.d(error.response?.data?.toString());
    //   logger.d(error.message.toString());
    //   if (error.response?.data != null) {
    //     return error.response?.data.toString();
    //   }
    //   return error.message;
    // }
  }
}
