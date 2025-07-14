// import 'package:flutter/cupertino.dart';
// import 'package:sakani/app/utils/api_env_config/app_logger_config.dart';
// import 'package:video_player/video_player.dart';
//
// import '../../../../../base_controllers_and_listeners/base_controller.dart';
//
// class AppVideoPlayerController extends BaseController {
//   late VideoPlayerController videoController;
//
//   final String videoUrl;
//
//   AppVideoPlayerController(this.videoUrl);
//
//   @override
//   void onInit() {
//     super.onInit();
//     logger.d(videoUrl);
//     videoController = VideoPlayerController.networkUrl(
//       Uri.parse(videoUrl),
//       videoPlayerOptions: VideoPlayerOptions(
//         allowBackgroundPlayback: false,
//         mixWithOthers: true,
//       ),
//     );
//     videoController.addListener(() async {
//       // logger.d(videoController.value.position.inSeconds);
//       update();
//       if (videoController.value.position == videoController.value.duration) {
//         // if (videoController.value.position.inSeconds == 7) {
//         logger.d('end');
//       }
//     });
//   }
//
//   @override
//   void onReady() async {
//     super.onReady();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       await videoController.initialize();
//       await videoController.play();
//     });
//   }
//
//   bool get isPlaying => videoController.value.isPlaying;
//
//   Key pupUpIconForDurationKey = UniqueKey();
//   toggleVideo() {
//     videoController.value.isPlaying
//         ? videoController.pause()
//         : videoController.play();
//     pupUpIconForDurationKey = UniqueKey();
//   }
//
//   @override
//   void onClose() {
//     videoController.dispose();
//     super.onClose();
//   }
//
//   @override
//   void dispose() {
//     videoController.dispose();
//     super.dispose();
//   }
// }
