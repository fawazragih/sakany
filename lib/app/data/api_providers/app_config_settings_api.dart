// import 'package:sakani/app/data/api_providers/base_configs/base_api.dart';
// import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
// import 'package:sakani/app/data/models/app_slider.dart';
// import 'package:sakani/app/data/models/currency_model.dart';
// import 'package:sakani/app/data/models/app_setting.dart';
//
// import '../models/api_response_models/general_response_model.dart';
// import 'base_configs/api_paths.dart';
//
// class AppConfigAndSettingsApi extends BaseApi {
//   getAppSettings() async {
//     return await dio.get(ApiPaths.appSetting).mapFromResponse(
//           (data) => GeneralResponseModel<List<AppSetting>, AppSetting>.fromJson(
//             json: data,
//             serialize: (object) => AppSetting.fromJson(object),
//           ),
//         );
//   }
//
//   getAppSlider() async {
//     return await dio.get(ApiPaths.appSlider).mapFromResponse(
//           (data) => GeneralResponseModel<List<AppSlider>, AppSlider>.fromJson(
//             json: data,
//             serialize: (object) => AppSlider.fromJson(object),
//           ),
//         );
//   }
//
//   getAvailableCurrency() async {
//     return await dio.get(ApiPaths.currencies).mapFromResponse(
//           (data) => GeneralResponseModel<List<Currency>, Currency>.fromJson(
//             json: data,
//             serialize: (object) => Currency.fromJson(object),
//           ),
//         );
//   }
// }
