// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../core/language_and_localization/app_strings.dart';
//
// class ImagePickerWidgetForm extends StatefulWidget {
//   final double height;
//   final double width;
//   final double radiusCircular;
//   final AlignmentGeometry alignmentGeometry;
//   final Widget image;
//   final Widget iconClick;
//   final String keyName;
//   final bool isRequired;
//   final Function upLoudImage;
//   final bool isUploaded;
//
//   const ImagePickerWidgetForm({
//     Key? key,
//     required this.height,
//     required this.width,
//     required this.radiusCircular,
//     required this.alignmentGeometry,
//     required this.image,
//     required this.keyName,
//     required this.isRequired,
//     required this.upLoudImage,
//     required this.iconClick,
//     required this.isUploaded,
//   }) : super(key: key);
//
//   @override
//   State<ImagePickerWidgetForm> createState() => _ImagePickerWidgetState();
// }
//
// class _ImagePickerWidgetState extends State<ImagePickerWidgetForm> {
//   File? storedIma;
//   File? savedIma;
//
//   Future<bool?> _imageSourceDialog(BuildContext context, dynamic field) async {
//     final size = MediaQuery.of(context).size;
//     return showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         title: Text(
//           MamaMiaAppStrings.pickImage.tr.capitalizeFirst!,
//           textAlign: TextAlign.center,
//         ),
//         content: Container(
//           height: size.height * 0.22,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   GestureDetector(
//                     onTap: () => _takePicture(ImageSource.camera, field),
//                     child: Wrap(
//                       direction: Axis.vertical,
//                       children: [
//                         // Image.asset(AppImages.CAMERA,
//                         //     width: 50.w, height: 50.h),
//                         Icon(
//                           Icons.camera_alt,
//                           size: 50.w,
//                         ),
//                         SizedBox(height: 10.h),
//                         Text(
//                           MamaMiaAppStrings.camera.tr.capitalizeFirst!,
//                         ),
//                       ],
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () => _takePicture(ImageSource.gallery, field),
//                     child: Wrap(
//                       direction: Axis.vertical,
//                       children: [
//                         Icon(
//                           Icons.photo_album,
//                           size: 50.w,
//                         ),
//                         SizedBox(height: 10.h),
//                         Text(MamaMiaAppStrings.gallery.tr.capitalizeFirst!),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20.h),
//               CupertinoButton(
//                   padding: const EdgeInsets.all(0),
//                   child: Container(
//                     height: 40.h,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: Get.theme.primaryColorLight,
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     child: Text(
//                       MamaMiaAppStrings.cancel.tr.capitalizeFirst!,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   onPressed: () => Navigator.of(context).pop()),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _takePicture(ImageSource source, dynamic field) async {
//     final picker = ImagePicker();
//
//     final imageFile = await picker.pickImage(
//       source: source,
//       maxWidth: 600,
//     );
//     if (imageFile == null) return;
//
//     storedIma = File(imageFile.path);
//
//     field.didChange(storedIma);
//
//     setState(() {});
//     savedIma = File(imageFile.path);
//     uploadImage();
//     Get.back();
//   }
//
//   bool loadingImage = false;
//   bool newImage = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return FormBuilderField(
//       name: widget.keyName,
//       validator: FormBuilderValidators.compose([
//         if (widget.isRequired) FormBuilderValidators.required(),
//       ]),
//       builder: (FormFieldState<dynamic> field) {
//         return Stack(alignment: Alignment.bottomCenter, children: <Widget>[
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               storedIma == null
//                   ? widget.image.paddingOnly(bottom: 10.h)
//                   : Container(
//                       width: 100,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         image: DecorationImage(
//                           fit: BoxFit.fill,
//                           image: FileImage(
//                             storedIma!,
//                           ),
//                         ),
//                       ),
//                     ).paddingOnly(bottom: 10.h),
//               Visibility(
//                 visible: loadingImage,
//                 child: const SpinKitSpinningLines(
//                   color: Colors.white,
//                   size: 80.0,
//                 ),
//               )
//             ],
//           ),
//           Align(
//               alignment: widget.alignmentGeometry,
//               //Alignment.bottomLeft,
//               child: InkWell(
//                   onTap: () => _imageSourceDialog(context, field),
//                   child: widget.iconClick)),
//         ]);
//       },
//     );
//   }
//
//   void uploadImage() async {
//     setState(() {
//       loadingImage = true;
//     });
//     newImage = await widget.upLoudImage(storedIma);
//     if (!newImage) storedIma = null;
//     setState(() {
//       loadingImage = false;
//     });
//   }
// }
