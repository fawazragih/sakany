import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani_mobile_app/app/data/api_providers/topic_api.dart';

class TopicRepository {
  final TopicApi _api = TopicApi();

  Future<SuccessOrError> fetchTopicBySystemName(String systemName) =>_api.fetchTopicBySystemName(systemName);

  Future<SuccessOrError> fetchTopicById(int topicId) =>_api.fetchTopicById(topicId);
}