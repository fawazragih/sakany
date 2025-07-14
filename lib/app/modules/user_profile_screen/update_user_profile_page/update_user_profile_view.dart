import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/api_env_config/app_logger_config.dart';
import '../../../utils/constants/const_strings.dart';
import 'update_user_profile_controller.dart';

class UpdateUserProfilePage extends StatelessWidget {
  static const String routeName = '/app/Update-Profile';
  const UpdateUserProfilePage({super.key});

  List<TextButton> get actions => [
    // TextButton(
    //     onPressed: () {
    //       Navigator.pop(context);
    //     },
    //     child: Text(_globalService.getString(ConstStrings.COMMON_NO))),
    // TextButton(
    //     onPressed: () {
    //       Navigator.pop(context);
    //       showDialog(
    //         context: context,
    //         builder: (_) =>
    //             AlertDialog(
    //               title: Text(
    //                 _globalService
    //                     .getString(
    //                     ConstStrings.DELETE_ACCOUNT_PASSWORD_DIALOG_TITLE),
    //               ),
    //               content: TextField(
    //                 autofocus: true,
    //                 obscureText: true,
    //                 decoration: const InputDecoration(
    //                   hintText: 'Enter your password',
    //                 ),
    //                 onChanged: (value) => password = value,
    //               ),
    //               actions: [
    //                 TextButton(
    //                     onPressed: () {
    //                       Navigator.pop(context);
    //                     },
    //                     child: Text(_globalService.getString(
    //                         ConstStrings.COMMON_NO))),
    //                 TextButton(
    //                     onPressed: () {
    //                       // login api call
    //                       Navigator.pop(context);
    //                       if (password?.isNotEmpty ?? false) {
    //                         _bloc.postLoginRequest(password!);
    //                       }
    //                     },
    //                     child: Text(_globalService.getString(
    //                         ConstStrings.COMMON_YES))),
    //               ],
    //             ),
    //       );
    //     },
    //     child: Text(_globalService.getString(ConstStrings.COMMON_YES))),
  ];

  @override
  Widget build(BuildContext context) {
    final UpdateUserProfileController controller =
        Get.put(UpdateUserProfileController());

    return Scaffold(
      body: Column(
        children: [
//           if (appLanding?.allowCustomersToUploadAvatars ==
//                   true) ...[
//             const SizedBox(height: 10),
//             StreamBuilder<ApiResponse<GetAvatarData>>(
//                 stream: _bloc.avatarStream,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData &&
//                       snapshot.data?.status == Status.COMPLETED) {
//                     return CircleAvatar(
//                       backgroundImage:
//                       (snapshot.data?.data?.avatarUrl?.isNotEmpty ??
//                           false) ==
//                           true
//                           ? NetworkImage(
//                           snapshot.data?.data?.avatarUrl ?? '')
//                           : const AssetImage('assets/user.png')
//                       as ImageProvider,
//                       backgroundColor: Colors.grey[200],
//                       radius: 50,
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         child: PopupMenuButton(
//                           icon: const Icon(Icons.edit_outlined),
//                           itemBuilder: (context) {
//                             return [
//                               PopupMenuItem(
//                                 value: 1,
//                                 child: Text(_globalService.getString(
//                                     ConstStrings.COMMON_UPLOAD)),
//                               ),
//                               if (snapshot.data?.data?.avatarUrl
//                                   ?.isNotEmpty ==
//                                   true)
//                                 PopupMenuItem(
//                                   value: 2,
//                                   child: Text(_globalService.getString(
//                                       ConstStrings
//                                           .ACCOUNT_REMOVE_AVATAR)),
//                                 )
//                             ];
//                           },
//                           onSelected: (int index) async {
//                             if (index == 1) {
//                               // upload
//                               FilePickerResult? result =
//                               await FilePicker.platform.pickFiles(
//                                 // type: FileType.image,
//                                 allowMultiple: false,
//                               );
// //TODO: edit default max value to the appropriate value
//                               var maxSize = _globalService
//                                   .getAppLandingData()
//                                   ?.avatarMaximumSizeBytes ??
//                                   0;
//
//                               if (result != null &&
//                                   result.files.single.size > maxSize) {
//                                 var msg =
//                                 _globalService.getStringWithNumber(
//                                     ConstStrings
//                                         .ACCOUNT_AVATAR_SIZE,
//                                     _globalService
//                                         .getAppLandingData()
//                                         ?.avatarMaximumSizeBytes ??
//                                         50);
//                                 showSnackBar(context, msg, true);
//                               } else if (result != null &&
//                                   result.files.single.size < maxSize) {
//                                 _bloc.uploadAvatar(
//                                     result.files.single.path ?? '');
//                               }
//                             } else if (index == 2) {
//                               // remove
//                               _bloc.removeAvatar();
//                             }
//                           },
//                         ),
//                       ),
//                     );
//                   } else {
//                     return const SizedBox.shrink();
//                   }
//                 }),
//           ],
          ///
          //   if (!isRegistrationMode) ...[
          //     changePasswordSection(),
          //     if (_globalService
          //         .getAppLandingData()
          //         ?.allowCustomersToDeleteAccount ??
          //         false)
          //     //accountDeletionSection()
          //       Align(
          //         alignment: Alignment.topRight,
          //         child: Padding(
          //           padding: EdgeInsets.symmetric(vertical: 16.0.h),
          //           child: InkWell(
          //             onTap: () => showDialog(
          //                 context: context,
          //                 builder: (_) {
          //                   return !kIsWeb && Platform.isIOS
          //                       ? CupertinoAlertDialog(
          //                     title: Text(_globalService.getString(
          //                         ConstStrings
          //                             .DELETE_ACCOUNT_DIALOG_TITLE)),
          //                     actions: actions,
          //                   )
          //                       : AlertDialog(
          //                     title: Text(_globalService.getString(
          //                         ConstStrings
          //                             .DELETE_ACCOUNT_DIALOG_TITLE)),
          //                     actions: actions,
          //                   );
          //                 }),
          //             child: Text(
          //               _globalService
          //                   .getString(ConstStrings.DELETE_ACCOUNT),
          //               style: Theme.of(context)
          //                   .textTheme
          //                   .bodyMedium
          //                   ?.copyWith(
          //                 color: Colors.red[800],
          //                 fontWeight: FontWeight.w600,
          //                 decoration: TextDecoration.underline,
          //                 fontSize: 17.sp,
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          //   ],
        ],
      ),
      // bottomNavigationBar: Align(
      //   alignment: Alignment.bottomCenter,
      //   child: Row(
      //     children: [
      //       Expanded(
      //           child: ActionButton(
      //               text: isRegistrationMode
      //                   ? _globalService
      //                   .getString(ConstStrings.REGISTER_BUTTON)
      //                   .toUpperCase()
      //                   : _globalService
      //                   .getString(ConstStrings.SAVE_BUTTON)
      //                   .toUpperCase(),
      //               shape: ButtonShape.RoundedTop,
      //               onClick: () {
      //                 removeFocusFromInputField(context);
      //
      //                 String attrErrorMsg =
      //                     attributeManager?.checkRequiredAttributes(
      //                         formData.customerAttributes ?? []) ??
      //                         AppStrings.error;
      //
      //                 String gdprErrorMsg = '';
      //                 formData.gdprConsents?.forEach((element) {
      //                   if (element.isRequired == true &&
      //                       element.accepted == false) {
      //                     gdprErrorMsg =
      //                     '$gdprErrorMsg${element.requiredMessage ?? ''}\n';
      //                   }
      //                 });
      //                 gdprErrorMsg.trimRight();
      //
      //                 if (attrErrorMsg.isNotEmpty) {
      //                   showSnackBar(context, attrErrorMsg, true);
      //                   return;
      //                 } else if ((formData.acceptPrivacyPolicyEnabled) &&
      //                     !(_bloc.privacyAccepted ?? false)) {
      //                   showSnackBar(
      //                       context,
      //                       _globalService.getString(
      //                           ConstStrings.REGISTER_ACCEPT_PRIVACY),
      //                       true);
      //                   return;
      //                 } else if (gdprErrorMsg.isNotEmpty) {
      //                   showSnackBar(context, gdprErrorMsg, true);
      //                   return;
      //                 } else {
      //                   if (_formKey.currentState?.validate() ?? false) {
      //                     _formKey.currentState?.save();
      //
      //                     if (isRegistrationMode) {
      //                       if (completeRegisterWithBasUserData) {
      //                         _bloc.postRegisterWithBasAuth(
      //                             formData,
      //                             attributeManager?.getSelectedAttributes(
      //                                 'customer_attribute') ??
      //                                 []);
      //                       } else {
      //                         _bloc.postRegisterFormData(
      //                             formData,
      //                             attributeManager?.getSelectedAttributes(
      //                                 'customer_attribute') ??
      //                                 []);
      //                       }
      //                     } else {
      //                       _bloc.posCustomerInfo(
      //                           formData,
      //                           attributeManager?.getSelectedAttributes(
      //                               'customer_attribute') ??
      //                               []);
      //                     }
      //                   }
      //                 }
      //               }))
      //     ],
      //   ),
      // ),
    );
  }

  Widget changePasswordSection() => Align(
    alignment: Alignment.topRight,
    child: InkWell(
      onTap: () {
        //TODO byMe
        logger.d('TODO');
        // Get.toNamed(ChangePasswordScreen.routeName);
      },
      child: Text(
        ConstStrings.CHANGE_PASSWORD.translate,
        style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
          color: Colors.blue[800],
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
          fontSize: 17.sp,
        ),
      ),
    ),
  );
}
