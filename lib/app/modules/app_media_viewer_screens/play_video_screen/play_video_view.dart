// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
//
// import '../../../global_widget/app_bar_widgets/custom_app_bar.dart';
// import 'play_video_controller.dart';
// import 'widget/app_video_player/app_video_player_view.dart';
//
// class PlayVideoScreen extends GetView<PlayVideoController> {
//   static const String routeName = '/play_video_screen';
//
//   const PlayVideoScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (MediaQuery.of(context).orientation == Orientation.landscape) {
//           await SystemChrome.setPreferredOrientations([
//             DeviceOrientation.portraitUp,
//             DeviceOrientation.portraitDown,
//           ]);
//         }
//         return Future.value(true);
//       },
//       child: Scaffold(
//         appBar: CustomAppBar(
//           title: controller.title,
//           translateTitle: true,
//         ),
//         body: Stack(
//           children: [
//             Center(
//               child: AppVideoPlayerWidget(
//                 videoUrl: controller.videoUrl,
//               ),
//             ),
//             // PositionedDirectional(
//             //   bottom: 60.h,
//             //   end: 16.w,
//             //   child: GetBuilder<PlayVideoController>(builder: (controller) {
//             //     return Column(
//             //       children: [
//             //         UiHelper.verticalSpaceSmall,
//             //         // FavoriteAndSaveFloatingButton(
//             //         //   iconData: !controller.recipe.isLiked
//             //         //       ? CookeryAppIcons.favorite
//             //         //       : CookeryAppIcons.unFavorite,
//             //         //   onPressed: () async =>
//             //         //       controller.likeRecipe(controller.recipe),
//             //         // ),
//             //         // UiHelper.verticalSpaceSmall,
//             //         // FavoriteAndSaveFloatingButton(
//             //         //   iconData: controller.recipe.isSavedToUserFavorite
//             //         //       ? CookeryAppIcons.saved
//             //         //       : CookeryAppIcons.unSave,
//             //         //   onPressed: () async =>
//             //         //       controller.addToFavorite(controller.recipe),
//             //         // ),
//             //       ],
//             //     );
//             //   }),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
