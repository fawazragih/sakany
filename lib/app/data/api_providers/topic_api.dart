import 'package:tamoily/app/data/api_providers/api_response_models/general_response_model.dart';
import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/models/topic_response.dart';

import 'base_configs/api_paths.dart';
import 'base_configs/base_api.dart';

class TopicApi extends BaseApi {
  Future<SuccessOrError> fetchTopicBySystemName(String systemName) async {
    // final response = await _helper.get('${Endpoints.topicBySystemName}/$systemName');
    //  TopicResponse.fromJson(response);
    return await dio
        .get('${ApiEndpoints.topicBySystemName}/$systemName')
        .mapFromResponse(
          (data) => GeneralResponseModel<TopicData, TopicData>.fromJson(
            json: data,
            serialize: TopicData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> fetchTopicById(int topicId) async {
    // final response = await _helper.get('${Endpoints.topicById}/$topicId');
    // return TopicResponse.fromJson(response);

    return await dio.get('${ApiEndpoints.topicById}/$topicId').mapFromResponse(
          (data) => GeneralResponseModel<TopicData, TopicData>.fromJson(
            json: data,
            serialize: TopicData.fromJson,
          ),
        );
  }
}
