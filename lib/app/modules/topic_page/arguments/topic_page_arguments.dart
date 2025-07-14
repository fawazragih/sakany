import 'package:app_extensions/app_extensions.dart';

class TopicPageArguments {
  int? topicId;
  String? topicName;

  TopicPageArguments({
    this.topicId,
    this.topicName,
  });

  Map<String, String> toJson() {
    return {
      'topicId': topicId?.toString() ?? '',
      'topicName': topicName ?? '',
    }..removeWhere((key, value) => value.isNullOrEmpty);
  }

  factory TopicPageArguments.fromJson(Map<String, dynamic> json) {
    return TopicPageArguments(
      topicId: int.tryParse(json['topicId']?.toString() ?? ''),
      topicName: json['topicName'],
    );
  }
}
