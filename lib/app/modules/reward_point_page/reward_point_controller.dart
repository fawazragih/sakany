import 'package:get/get.dart';
import 'package:sakani/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani/app/base_controllers_and_listeners/pagination_logic_controller.dart';
import 'package:sakani/app/data/api_providers/api_response_models/general_response_model.dart';
import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/models/reward_point_response.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';

import 'repository/reward_point_repository.dart';

class RewardPointController extends BaseController
    with PaginationLogicController<RewardPoint> {
  final RewardPointRepository _repository = RewardPointRepository();

  RewardPointData? rewardPoint;

  RxBool doneLoading = RxBool(false);


  @override
  void onInit() {
    super.onInit();
    initPagingController();
  }

  String? get displayMessage {
    var text1 = ConstStrings.REWARD_POINT_BALANCE_CURRENT.translate
        .replaceAll("{0}", rewardPoint?.rewardPointsBalance.toString() ?? '')
        .replaceAll("{1}", rewardPoint?.rewardPointsAmount.toString() ?? '');

    var text2 = ConstStrings.REWARD_POINT_BALANCE_MIN.translate
        .replaceAll(
            "{0}", rewardPoint?.minimumRewardPointsBalance.toString() ?? '')
        .replaceAll(
            "{1}", rewardPoint?.minimumRewardPointsAmount.toString() ?? '');

    String displayMsg = (rewardPoint?.minimumRewardPointsBalance ?? 0.0) <= 0
        ? text1
        : "$text1\n$text2";

    return displayMsg;
  }

  @override
  Future<SuccessOrError> getData(int page) async {
    SuccessOrError result = await _repository.fetchRewardPointDetails(page + 1);

    if (result.success) {
      RewardPointData responseData = result.response?.data;
      List<RewardPoint> productsList = responseData.rewardPoints ?? [];
      rewardPoint = responseData;
      doneLoading.value = true;
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
