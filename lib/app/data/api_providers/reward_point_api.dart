import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/models/reward_point_response.dart';

import 'api_response_models/general_response_model.dart';
import 'base_configs/api_paths.dart';
import 'base_configs/base_api.dart';

class RewardPointApi extends BaseApi {
  Future<SuccessOrError> fetchRewardPointDetails(int pageNumber) async {
    return await dio
        .get('${ApiEndpoints.rewardPoints}/$pageNumber')
        .mapFromResponse(
          (data) =>
              GeneralResponseModel<RewardPointData, RewardPointData>.fromJson(
            json: data,
            serialize: RewardPointData.fromJson,
          ),
        );
  }
}
