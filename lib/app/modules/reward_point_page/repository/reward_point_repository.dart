import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani_mobile_app/app/data/api_providers/reward_point_api.dart';

class RewardPointRepository {
  final RewardPointApi _api = RewardPointApi();

  Future<SuccessOrError> fetchRewardPointDetails(int pageNumber) =>
      _api.fetchRewardPointDetails(pageNumber);
}
