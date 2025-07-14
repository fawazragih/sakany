import 'package:sakani/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani/app/data/models/subscription_list_response.dart';
import 'package:sakani/app/modules/subscription_page/repository/subscription_repository.dart';

import '../../base_controllers_and_listeners/pagination_logic_controller.dart';
import '../../data/api_providers/api_response_models/general_response_model.dart';
import '../../data/api_providers/base_configs/handling_dio_response.dart';

class SubscriptionController extends BaseController
    with PaginationLogicController<Subscription> {
  final SubscriptionRepository _repository = SubscriptionRepository();

  SubscriptionListData? cachedData;
   List<int> selectedItems = [];

  setSelectionStatus(int id, bool selected) {
    selected ? selectedItems.add(id) : selectedItems.remove(id);
  }

  isSelected(int id) {
    return selectedItems.contains(id);
  }


  unsubscribeSelected() async {
    // if (selectedItems.isEmpty) {
    //   return;
    // }
    //
    // _pageNumber = 1;
    // var reqBody = FormValuesRequestBody(
    //   formValues: selectedItems
    //       .map((e) => FormValue(key: 'biss$e', value: 'on'))
    //       .toList(),
    // );
    //
    // loaderSink.add(ApiResponse.loading());
    // try {
    //   SubscriptionListResponse unSubResponse;
    //   // unsubscribe api returns http 302 from flutter but 200 from postman
    //   // in both cased products are being unsubscribed successfully
    //   // this is a temporary workaround. have to fix later
    //   try {
    //     unSubResponse = await _repository.unsubscribe(reqBody);
    //   } catch (e) {
    //     // if response is http 302
    //     unSubResponse = await _repository.fetchSubscriptions(_pageNumber);
    //   }
    //   _cachedData = unSubResponse.data;
    //   subscriptionListSink.add(ApiResponse.completed(_cachedData));
    //   loaderSink.add(ApiResponse.completed(''));
    //
    //   _hasNextPage = (unSubResponse.data?.pagerModel?.currentPage ?? 1) <
    //       (unSubResponse.data?.pagerModel?.totalPages ?? 1);
    //   _pageNumber++;
    // } catch (e) {
    //   subscriptionListSink.add(ApiResponse.error(e.toString()));
    //   loaderSink.add(ApiResponse.error(e.toString()));
    //   print(e.toString());
    // }
  }

  @override
  void onInit() {
    super.onInit();
    initPagingController();
  }

  @override
  Future<SuccessOrError> getData(int page) async {
    SuccessOrError result = await _repository.fetchSubscriptions(page);

    if (result.success) {
      SubscriptionListData responseData = result.response?.data;
      List<Subscription> productsList = /*responseData.subscriptions ??*/ [Subscription.fake()];
      cachedData = responseData;
      // doneLoading.value = true;
      return (
        GeneralResponseModel(
          data: productsList,
          hasMore: responseData.hasMorePages,
          success: true,
        ),
        null
      );
    } else {
      return (null, result.error);
    }
  }

  @override
  disposePaginationController() {
    pagingController.dispose();
  }

  @override
  void onClose() {
    disposePaginationController();
    super.onClose();
  }
}
