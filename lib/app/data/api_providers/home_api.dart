import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/models/home_slider_response.dart';
import 'package:sakani/app/data/models/product_summary.dart';

import '../models/category_tree/category_tree_response.dart';
import '../models/home/categories_with_products_response.dart';
import '../models/home/manufacturers_response.dart';
import 'api_response_models/general_response_model.dart';
import 'base_configs/api_paths.dart';
import 'base_configs/base_api.dart';

class HomeApi extends BaseApi {
  Future<SuccessOrError> fetchCategories() async {
    return await dio.get(ApiEndpoints.categoryTree).mapFromResponse(
          (data) => GeneralResponseModel<List<CategoryTreeResponseData>,
              CategoryTreeResponseData>.fromJson(
            json: data,
            serialize: CategoryTreeResponseData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> getHomePageSliders() async {
    return await dio.get(ApiEndpoints.homePageBanner).mapFromResponse(
          (data) =>
              GeneralResponseModel<HomeSliderData, HomeSliderData>.fromJson(
            json: data,
            serialize: HomeSliderData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> getFeaturedProducts() async {
    return await dio.get(ApiEndpoints.homeFeaturedProduct).mapFromResponse(
          (data) => GeneralResponseModel<List<ProductSummary>,
              ProductSummary>.fromJson(
            json: data,
            serialize: ProductSummary.fromJson,
          ),
        );
  }

  Future<SuccessOrError> getBestSellerProducts() async {
    return await dio.get(ApiEndpoints.homeBestsellerProducts).mapFromResponse(
          (data) => GeneralResponseModel<List<ProductSummary>,
              ProductSummary>.fromJson(
            json: data,
            serialize: ProductSummary.fromJson,
          ),
        );
  }

  Future<SuccessOrError> getCategoriesWithProducts() async {
    return await dio.get(ApiEndpoints.homeCategoryWithProducts).mapFromResponse(
          (data) => GeneralResponseModel<List<CategoriesWithProducts>,
              CategoriesWithProducts>.fromJson(
            json: data,
            serialize: CategoriesWithProducts.fromJson,
          ),
        );
  }

  Future<SuccessOrError> getManufacturers() async {
    return await dio.get(ApiEndpoints.homeManufacturers).mapFromResponse(
          (data) => GeneralResponseModel<List<ManufacturerData>,
              ManufacturerData>.fromJson(
            json: data,
            serialize: ManufacturerData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> getAllManufacturers() async {
    return await dio.get(ApiEndpoints.allManufacturers).mapFromResponse(
          (data) => GeneralResponseModel<List<ManufacturerData>,
              ManufacturerData>.fromJson(
            json: data,
            serialize: ManufacturerData.fromJson,
          ),
        );
  }
}
