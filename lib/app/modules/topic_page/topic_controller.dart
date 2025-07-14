import 'package:get/get.dart';
import 'package:sakani/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/models/topic_response.dart';

import 'arguments/topic_page_arguments.dart';
import 'repository/topic_repository.dart';

class TopicController extends BaseController {
  final TopicRepository _repository = TopicRepository();

  TopicPageArguments? arguments;

  // String? htmlData;

  TopicData? data;

  @override
  void onInit() {
    super.onInit();

    arguments = TopicPageArguments.fromJson(Get.parameters);

    fetchData();
  }

  void fetchData() {
    if (arguments != null && arguments!.topicId != null) {
      fetchTopicById(arguments!.topicId!);
    } else if (arguments != null && arguments!.topicName != null) {
      fetchTopicBySystemName(arguments!.topicName!);
    } else {
      setShowRetryButton(true, errorMsg: 'No topic SystemName or Id found');
    }
  }

  fetchTopicById(int topicId) async {
    // topicSink.add(ApiResponse.loading());
    // try {
    //   TopicResponse response = await _repository.fetchTopicById(topicId);
    //   topicSink.add(ApiResponse.completed(response));
    // } catch (e) {
    //   topicSink.add(ApiResponse.error(e.toString()));
    //   print(e);
    // }
    setBusy(true);
    SuccessOrError result = await _repository.fetchTopicById(topicId);
    if (result.success) {
      data = result.response?.data;
      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  fetchTopicBySystemName(String systemName) async {
    // topicSink.add(ApiResponse.loading());
    // try {
    //   TopicResponse response = await _repository.fetchTopicBySystemName(systemName);
    //   topicSink.add(ApiResponse.completed(response));
    //   pageTitleSink.add(response.data?.title ?? '');
    // } catch (e) {
    //   topicSink.add(ApiResponse.error(e.toString()));
    //   print(e);
    // }
    setBusy(true);
    SuccessOrError result =
        await _repository.fetchTopicBySystemName(systemName);
    if (result.success) {
      data = result.response?.data;
      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }
}
