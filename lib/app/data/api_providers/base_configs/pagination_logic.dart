import 'package:app_extensions/app_extensions.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import '../api_response_models/general_response_model.dart';

class PaginationLogic {
  final Logger logger = Logger();

  final Dio dio;

  PaginationLogic(this.dio);

  ///...
  // int page = 1;

  ///...

  Future<SuccessOrError> loadMore<T>(
    String url,
    int page, {
    required OnInsideDataSerialize onInsideDataSerialize,
    int requiredOnPage = 5,
    // ApiFilter? apiFilter,
    Map<String, dynamic>? moreParameter,
    CancelToken? cancelToken,
  }) async {
    return await dio
        .get(
      url,
      cancelToken: cancelToken,
      queryParameters: <String, dynamic>{
        'SkipCount': page,
        "MaxResultCount": requiredOnPage
      }
        ..addAll(moreParameter ?? {})
        ..removeWhere((key, value) => value == null),
      // data: <String, dynamic>{'pageNum': page, "limit": requiredOnPage}
      //   ..addAll(moreParameter ?? {})
      //   ..removeWhere((key, value) => value == null),
    )
        .mapFromResponse((decodedJsonData) {
      bool hasMore = true;

      // if (decodedJsonData['result'] is List) {
      //   bool noMore = (decodedJsonData['result'] as List).isEmpty ||
      //       (decodedJsonData['result'] as List).length < requiredOnPage;
      //   hasMore = !noMore;
      // }

      // logger.d(decodedJsonData);
      // logger.d(decodedJsonData['data']);
      // logger.d(decodedJsonData['hasNext']);

      // hasMore = decodedJsonData['hasNext']?.toString().valueTypeToBool ?? false;

      // if (decodedJsonData['pagination'] != null) {
      //   hasMore = decodedJsonData['pagination']['current_page'] !=
      //       decodedJsonData['pagination']['last_page'];
      // }
      // if (decodedJsonData['data'] is Map) {
      //   hasMore = false;
      // }

      var listOfItems = decodedJsonData['items'] as List?;

      int counts = int.tryParse(decodedJsonData['totalCount'].toString()) ?? 0;

      hasMore = listOfItems.isNotNullOrEmpty &&
          counts > listOfItems!.length &&
          listOfItems.length < requiredOnPage;

      logger.d(hasMore);

      return GeneralResponseModel<List<T>, T>.fromJson(
        json: decodedJsonData,
        serialize: onInsideDataSerialize,
        hasMore: hasMore,
      );
    });
  }

// loadCatProduct(
//   String url,
//   int page, {
//   int requiredOnPage = 5,
//   CancelToken? cancelToken,
//   // ApiFilter? apiFilter,
//   Map<String, dynamic>? moreParameter,
// }) async {
//   // logger.d(page);
//   return await dio
//       .post(
//     url,
//     cancelToken: cancelToken,
//     data: <String, dynamic>{'page': page, "limit": requiredOnPage}
//       ..addAll(moreParameter ?? {})
//       ..removeWhere((key, value) => value == null),
//   )
//       .mapFromResponse((decodedJsonData) {
//     bool hasMore = true;
//
//     var goodsFields = decodedJsonData['data'] is List
//         ? decodedJsonData['data']
//         : decodedJsonData['data']?['goods'];
//
//     if (goodsFields != null &&
//         goodsFields is List &&
//         goodsFields.isNullOrEmpty) {
//       hasMore = false;
//     }
//
//     // logger.d(hasMore);
//
//     return GeneralResponseModel<CatProduct, CatProduct>.fromJson(
//       json: decodedJsonData,
//       serialize: (data) => CatProduct.fromJson(data),
//       hasMore: hasMore,
//     );
//   });
// }
}
