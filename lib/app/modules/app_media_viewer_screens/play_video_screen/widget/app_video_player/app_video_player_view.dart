// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// class AppVideoPlayerWidget extends StatelessWidget {
//   final String videoUrl;
//
//   const AppVideoPlayerWidget({super.key, required this.videoUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AppVideoPlayerController>(
//       init: AppVideoPlayerController(videoUrl),
//       builder: (controller) {
//         return Stack(
//           children: [
//             InkWell(
//               onTap: controller.videoController.value.isInitialized
//                   ? controller.toggleVideo
//                   : null,
//               child: VideoPlayer(
//                 controller.videoController,
//               ),
//             ),
//             Positioned(
//               bottom: 24.h,
//               left: 10.w,
//               right: 10.w,
//               height: 8.h,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12.0),
//                 child: VideoProgressIndicator(
//                     controller.videoController, //video player controller
//                     allowScrubbing: true,
//                     padding: EdgeInsets.zero,
//                     colors: VideoProgressColors(
//                       backgroundColor: Colors.grey.shade400,
//                       playedColor: Theme.of(context).colorScheme.primary,
//                       bufferedColor: Colors.grey.shade200.withOpacity(0.5),
//                     )),
//               ),
//             ),
//             Center(
//               child: (!controller.videoController.value.isInitialized ||
//                       controller.videoController.value.isBuffering ||
//                       controller.videoController.value.isLooping)
//                   ? CircularProgressIndicator(
//                       color: Theme.of(context).colorScheme.primary,
//                     )
//                   : PupUpIconForDuration(
//                       key: controller.pupUpIconForDurationKey,
//                       hideAfterSecond: controller.isPlaying,
//                       onTap: controller.toggleVideo,
//                       iconData:
//                           controller.isPlaying ? Icons.pause : Icons.play_arrow,
//                     ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// class PupUpIconForDuration extends StatefulWidget {
//   final bool hideAfterSecond;
//   final IconData iconData;
//   final VoidCallback? onTap;
//
//   const PupUpIconForDuration(
//       {super.key,
//       this.hideAfterSecond = true,
//       required this.iconData,
//       this.onTap});
//
//   @override
//   State<PupUpIconForDuration> createState() => _PupUpIconForDurationState();
// }
//
// class _PupUpIconForDurationState extends State<PupUpIconForDuration> {
//   bool _visible = true;
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.hideAfterSecond) {
//       Future.delayed(
//           const Duration(
//             milliseconds: 1000,
//           ), () {
//         if (mounted) {
//           setState(() {
//             _visible = false;
//           });
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       maintainSize: true,
//       maintainAnimation: true,
//       maintainState: true,
//       visible: _visible,
//       child: Card(
//         shape: const CircleBorder(),
//         color: Theme.of(context).cardColor.withOpacity(0.4),
//         child: InkWell(
//           onTap: widget.onTap,
//           child: Icon(
//             widget.iconData,
//             size: 32.0,
//             color: Theme.of(context).colorScheme.secondary,
//           ).paddingAll(
//             16.0,
//           ),
//         ),
//       ),
//     );
//   }
// }
