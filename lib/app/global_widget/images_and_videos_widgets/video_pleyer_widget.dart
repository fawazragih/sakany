// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import '../app_ui_helper/ui_helpers.dart';
//
// class VideoPlayerWidget extends StatefulWidget {
//   final String? url;
//   final bool autoPlay;
//   final bool enterFullscreen;
//   final VoidCallback? onPlayVideo;
//   final File? file;
//
//   const VideoPlayerWidget({
//     super.key,
//     this.url,
//     this.file,
//     this.onPlayVideo,
//     this.autoPlay = false,
//     this.enterFullscreen = false,
//   });
//
//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }
//
// class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
//     with WidgetsBindingObserver {
//   FlickManager? flickManager;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//
//     if (widget.url != null) {
//       flickManager = FlickManager(
//         autoPlay: widget.autoPlay,
//         autoInitialize: true,
//         videoPlayerController: VideoPlayerController.networkUrl(
//           Uri.parse(widget.url!),
//           // videoPlayerOptions: VideoPlayerOptions(
//           // )
//         ),
//         // onVideoEnd: () {
//         //   // print('video got end');
//         // },
//       );
//     }
//     if (widget.file != null) {
//       flickManager = FlickManager(
//         autoPlay: widget.autoPlay,
//         autoInitialize: true,
//         videoPlayerController: VideoPlayerController.file(widget.file!),
//         // onVideoEnd: () {
//         //   print('video got end');
//         // },
//       );
//     }
//     if (widget.enterFullscreen) {
//       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//         flickManager?.flickControlManager?.enterFullscreen();
//       });
//     }
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//     if (state == AppLifecycleState.inactive ||
//         state == AppLifecycleState.detached) {
//       return;
//     }
//     bool isBackground = state == AppLifecycleState.paused;
//     if (isBackground) {
//       pauseVideo();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 16 / 9,
//       child: flickManager != null
//           ? FlickVideoPlayerWidget(
//               flickManager: flickManager!,
//             )
//           : const NoVideoWidget(),
//     );
//   }
//
//   void pauseVideo() {
//     if (flickManager?.flickVideoManager?.isPlaying ?? false) {
//       flickManager?.flickControlManager?.pause();
//     }
//   }
//
//   @override
//   void dispose() {
//     flickManager?.dispose();
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
// }
//
// class FlickVideoPlayerWidget extends StatelessWidget {
//   const FlickVideoPlayerWidget({
//     super.key,
//     required this.flickManager,
//   });
//   final FlickManager flickManager;
//
//   @override
//   Widget build(BuildContext context) {
//     return FlickVideoPlayer(
//       flickManager: flickManager,
//       preferredDeviceOrientationFullscreen: const [
//         DeviceOrientation.portraitUp
//       ],
//       preferredDeviceOrientation: const [DeviceOrientation.portraitUp],
//       flickVideoWithControls: FlickVideoWithControls(
//         videoFit: BoxFit.contain,
//         // aspectRatioWhenLoading: 0.2,
//         iconThemeData: IconThemeData(
//           color: Get.theme.primaryColor,
//           opacity: 1.0,
//         ),
//         controls: FlickPortraitControls(
//           iconSize: 24,
//           progressBarSettings: FlickProgressBarSettings(
//             curveRadius: 16,
//             handleRadius: 8,
//             // padding: EdgeInsets.zero,
//             playedColor: Get.theme.primaryColor.withBlue(150),
//             handleColor: Colors.white,
//             backgroundColor: Colors.grey.shade400,
//             bufferedColor: Colors.grey.shade600,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class NoVideoWidget extends StatelessWidget {
//   const NoVideoWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black54,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         // crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const Icon(
//             Icons.warning_amber_sharp,
//             color: Colors.white,
//             size: 48,
//           ),
//           UiHelper.verticalSpaceSmall,
//           Text(
//             'No video',
//             style: Get.textTheme.titleMedium,
//           ),
//         ],
//       ),
//     );
//   }
// }
