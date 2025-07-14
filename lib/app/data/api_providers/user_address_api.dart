// import 'package:sakani/app/data/api_providers/base_configs/base_api.dart';
// import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
// import 'package:sakani/app/data/models/user_address.dart';
//
// import '../models/api_response_models/general_response_model.dart';
// import 'base_configs/api_paths.dart';
// import 'base_configs/pagination_logic.dart';
//
// class UserAddressApi extends BaseApi {
//   addNewAddress(UserAddress userAddress) async {
//     return await dio
//         .post(ApiPaths.addresses, data: userAddress.toJson())
//         .mapFromResponse(
//           (data) => GeneralResponseModel<UserAddress, UserAddress>.fromJson(
//             json: data,
//             serialize: (object) => UserAddress.fromJson(object),
//           ),
//         );
//   }
//
//   PaginationLogic? _paginationLogic;
//
//   PaginationLogic get paginationLogic =>
//       _paginationLogic ??= PaginationLogic(dio);
//
//   getMore({
//     required int page,
//     int? onPage,
//   }) async {
//     return await paginationLogic.loadMore<UserAddress>(
//       ApiPaths.addresses,
//       page,
//       requiredOnPage: onPage ?? 6,
//       onParseObject: (data) => UserAddress.fromJson(data),
//     );
//   }
//
//   getUserAddresses() async {
//     return await dio.get(ApiPaths.addresses).mapFromResponse(
//           (data) =>
//               GeneralResponseModel<List<UserAddress>, UserAddress>.fromJson(
//             json: data,
//             serialize: (object) => UserAddress.fromJson(object),
//           ),
//         );
//   }
//
//   deleteAddress(UserAddress userAddress) async {
//     return await dio.delete(ApiPaths.addressesWithId(userAddress.id!),
//         data: {}).mapFromResponse(
//       (data) => GeneralResponseModel.fromJson(
//         json: data,
//       ),
//     );
//   }
//
//   getCountries() async {
//     // return await dio.get(ApiPaths.countries).mapFromResponse(
//     //       (data) => GeneralResponseModel<List<Country>, Country>.fromMap(
//     //         map: data,
//     //         serialize: (object) => Country.fromJson(object),
//     //       ),
//     //     );
//   }
//
//   getStates(int countryId) async {
//     // return await dio.get(ApiPaths.stateOfCountry(countryId)).mapFromResponse(
//     //       (data) =>
//     //           GeneralResponseModel<List<StateOrCity>, StateOrCity>.fromMap(
//     //         map: data,
//     //         serialize: (object) => StateOrCity.fromJson(object),
//     //       ),
//     //     );
//   }
//
//   // getCities(int countryId, int stateId) async {
//   //   return await dio.get(ApiPaths.citiesOfState(stateId)).mapFromResponse(
//   //         (data) =>
//   //             GeneralResponseModel<List<StateOrCity>, StateOrCity>.fromMap(
//   //           map: data,
//   //           serialize: (object) => StateOrCity.fromJson(object),
//   //         ),
//   //       );
//   // }
// }
