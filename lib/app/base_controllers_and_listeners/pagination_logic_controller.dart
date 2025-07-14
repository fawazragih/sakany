import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani_mobile_app/app/utils/api_env_config/app_logger_config.dart';
import '../data/api_providers/api_response_models/general_exception.dart';
import '../data/api_providers/api_response_models/general_response_model.dart';

mixin PaginationLogicController<T> {
  late PagingController<int, T> pagingController;

  Future<SuccessOrError> getData(int page);

  disposePaginationController();

  void initPagingController() {
    pagingController = PagingController(firstPageKey: 0);
    pagingController.addPageRequestListener((pageKey) async {
      await _fetchingData(pageKey);
    });
  }

  /// pagination variables
  Future<void> _fetchingData(int page) async {
    SuccessOrError result = await getData(page);
    if (result.success) {
      //logger.i(result.success);
      if (result.success) {
        addData(responseModel: result.response, pageKey: page);
      } else {
        logger.e(result.error.toString());
        pagingController.error =
            GeneralException(message: result.error.toString());
      }
    } else {
      pagingController.error = result.error;
    }
  }

  static ValueChanged<GeneralResponseModel?>? onAddData;

  addData({
    required GeneralResponseModel? responseModel,
    required int pageKey,
  }) {
    onAddData?.call(responseModel);
    if (responseModel?.hasMore == false) {
      pagingController.appendLastPage(responseModel?.data);
    } else {
      final int nextPageKey = pageKey + 1;
      pagingController.appendPage(
        responseModel?.data,
        nextPageKey,
      );
    }
  }
}
