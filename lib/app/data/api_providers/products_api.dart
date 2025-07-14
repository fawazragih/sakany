import 'package:sakani/app/data/api_providers/base_configs/base_api.dart';
import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/models/product_attr_change_response.dart';
import 'package:sakani/app/data/models/requestbody/form_values_request_body.dart';
import 'package:sakani/app/modules/product_list_page/argument/product_list_argument.dart';
import 'package:sakani/app/utils/constants/app_constants.dart';
import '../models/BaseResponse.dart';
import '../models/add_to_cart_response.dart';
import '../models/product_details_response.dart';
import '../models/product_list/product_list_response.dart';
import '../models/product_summary.dart';
import '../models/subscription_status_response.dart';
import 'api_response_models/general_response_model.dart';
import 'base_configs/api_paths.dart';
import 'share_api.dart';

class ProductsApi extends BaseApi with SharedApi {
  // PaginationLogic? _paginationLogic;
  //
  // PaginationLogic get paginationLogic =>
  //     _paginationLogic ??= PaginationLogic(dio);

  // Future<SuccessOrError> getMore({
  //   required int page,
  //   ApiFilter? apiFilter,
  //   int? onPage,
  // }) async {
  //   return await paginationLogic.loadMore<Product>(
  //     ApiEndpoints.products,
  //     page,
  //     requiredOnPage: onPage ?? 10,
  //     moreParameter: apiFilter?.toJson(),
  //     // cancelToken: cancelToken,
  //     onInsideDataSerialize: (data) => Product.fromJson(data),
  //   );
  // }

  Future<SuccessOrError> getMore({
    required GetProductListBy type,
    required int categoryId,
    required Map<String, dynamic> queryParams,
  }) async {
    String? endpoint;
    switch (type) {
      case GetProductListBy.CATEGORY:
        endpoint = ApiEndpoints.productListCategoryTree;
        break;
      case GetProductListBy.MANUFACTURER:
        endpoint = ApiEndpoints.productListManufacturer;
        break;
      case GetProductListBy.TAG:
        endpoint = ApiEndpoints.productListTag;
        break;
      case GetProductListBy.VENDOR:
        endpoint = ApiEndpoints.productListVendor;
        break;
    }

    return await dio
        .get(
          '$endpoint/$categoryId',
          // url,
          queryParameters: queryParams,
        )
        .mapFromResponse(
          (data) =>
              GeneralResponseModel<ProductListData, ProductListData>.fromJson(
            json: data,
            serialize: ProductListData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> fetchProductDetails({
    required int productId,
    bool updateCart = false,
    int? updateCartItemId,
  }) async {
    Map<String, String> queryParams = {
      'updatecartitemid': updateCartItemId.toString()
    };
    return await dio
        .get(
          ApiEndpoints.productDetails(productId),
          queryParameters: updateCart ? queryParams : null,
        )
        .mapFromResponse(
          (data) =>
              GeneralResponseModel<ProductDetails, ProductDetails>.fromJson(
            json: data,
            serialize: ProductDetails.fromJson,
          ),
        );
  }

  Future<SuccessOrError> addProductToCart({
    required int productId,
    required int cartType,
    required FormValuesRequestBody requestBody,
  }) async {
    return await dio
        .post(
          '${ApiEndpoints.addProductToCart}/$productId/$cartType',
          data: requestBody.toJson(),
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<AddToCartData, AddToCartData>.fromJson(
            json: data,
            serialize: AddToCartData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> fetchRelatedProducts({required int productId}) async {
    return await dio
        .get('${ApiEndpoints.relatedProducts}/$productId/300')
        .mapFromResponse(
          (data) => GeneralResponseModel<List<ProductSummary>,
              ProductSummary>.fromJson(
            json: data,
            serialize: ProductSummary.fromJson,
          ),
        );
  }

  Future<SuccessOrError> fetchCrossSellProducts(
      {required int productId}) async {
    return await dio
        .get(
          '${ApiEndpoints.crossSellProduct}/$productId/300',
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<List<ProductSummary>,
              ProductSummary>.fromJson(
            json: data,
            serialize: ProductSummary.fromJson,
          ),
        );
  }

  Future<SuccessOrError> postSelectedAttributes({
    required int productId,
    required FormValuesRequestBody requestBody,
  }) async {
    return await dio
        .post(
          '${ApiEndpoints.productAttributeChange}/$productId',
          data: requestBody.toJson(),
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<ProductAttrChangeData,
              ProductAttrChangeData>.fromJson(
            json: data,
            serialize: ProductAttrChangeData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> uploadFile({
    required String filePath,
    required String attributeId,
  }) async {
    return super.uploadMultipartFile(
      filePath: filePath,
      url: '${ApiEndpoints.uploadFileProductAttribute}/$attributeId',
    );
  }

  Future<SuccessOrError> downloadSample({required int productId}) async {
    return await dio.get('${ApiEndpoints.sampleDownload}/$productId').mapFromResponse(
        (data) => GeneralResponseModel(),
        customHandle: fileDownloadCustomHandle
        // customHandle: (data, response) {
        //   FileResponse responseJson;
        //
        //   String? contentType = response.headers.map['content-type']?.firstOrNull;
        //   // var contentType = response.headers. ?? '';
        //
        //   if (contentType?.contains('application/json') == true) {
        //     responseJson = FileResponse(jsonStr: response.data);
        //   } else {
        //     List<String> tokens =
        //         response.headers.map['content-disposition'] ?? [];
        //     String filename = 'new_file.${contentType?.split('/').last}';
        //     for (var i = 0; i < tokens.length; i++) {
        //       if (tokens[i].contains('filename') &&
        //           !tokens[i].contains('filename*')) {
        //         filename = tokens[i]
        //             .substring(tokens[i].indexOf("=") + 1, tokens[i].length);
        //         break;
        //       }
        //     }
        //     responseJson =
        //         FileResponse(fileBytes: response.data, filename: filename);
        //   }
        //
        //   return GeneralResponseModel<FileResponse, FileResponse>.fromJson(
        //     json: data,
        //     serialize: (_) => responseJson,
        //   );
        // },
        );
  }

  // Future<FileDownloadResponse<SampleDownloadResponse>> downloadSample(
  //     int productId) async {
  //   final FileResponse response =
  //       await _helper.getFile('${Endpoints.sampleDownload}/$productId');
  //
  //   if (response.isFile) {
  //     return FileDownloadResponse<SampleDownloadResponse>(
  //       file: await saveFileToDisk(response, showNotification: true),
  //     );
  //   } else {
  //     return FileDownloadResponse<SampleDownloadResponse>(
  //       jsonResponse: SampleDownloadResponse.fromJson(response.jsonStr),
  //     );
  //   }
  // }

  Future<SuccessOrError> fetchSubscriptionStatus(
      {required int productId}) async {
    return await dio
        .get('${ApiEndpoints.subscriptionStatus}/$productId')
        .mapFromResponse(
          (data) => GeneralResponseModel<SubscriptionStatusResponseData,
              SubscriptionStatusResponseData>.fromJson(
            json: data,
            serialize: SubscriptionStatusResponseData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> changeSubscriptionStatus(
      {required int productId}) async {
    return await dio
        .post('${ApiEndpoints.subscriptionStatus}/$productId',
            data: AppConstants.EMPTY_POST_BODY)
        .mapFromResponse(
          (data) => GeneralResponseModel<BaseResponse, BaseResponse>.fromJson(
            json: data,
            serialize: BaseResponse.fromJson,
          ),
        );
  }

  Future<SuccessOrError> fetchProductByBarcode(
      {required String barcodeValue}) async {
    return await dio
        .get('${ApiEndpoints.productByBarcode}/$barcodeValue')
        .mapFromResponse(
          (data) =>
              GeneralResponseModel<ProductDetails, ProductDetails>.fromJson(
            json: data,
            serialize: ProductDetails.fromJson,
          ),
        );
  }
}
