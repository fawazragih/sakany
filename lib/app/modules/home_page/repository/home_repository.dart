import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/api_providers/home_api.dart';

class HomeRepository {

  HomeRepository._();

  static final HomeRepository _instance = HomeRepository._();

  static HomeRepository get instance => _instance;


  final HomeApi _api = HomeApi();

  Future<SuccessOrError> fetchCategories() {
    return _api.fetchCategories();
  }

  Future<SuccessOrError> fetchHomePageSliders() {
    return _api.getHomePageSliders();
  }

  Future<SuccessOrError> fetchFeaturedProducts() {
    return _api.getFeaturedProducts();
  }

  Future<SuccessOrError> fetchBestSellerProducts() {
    return _api.getBestSellerProducts();
  }

  Future<SuccessOrError> fetchCategoriesWithProducts() {
    return _api.getCategoriesWithProducts();
  }

  Future<SuccessOrError> fetchManufacturers() {
    return _api.getManufacturers();
  }

  Future<SuccessOrError> fetchAllManufacturers() {
    return _api.getAllManufacturers();
  }
}
