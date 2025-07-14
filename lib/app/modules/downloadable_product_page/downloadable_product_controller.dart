import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani_mobile_app/app/core/language_and_localization/app_strings.dart';
import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani_mobile_app/app/data/models/downloadable_product_response.dart';
import 'package:sakani_mobile_app/app/data/models/file_download_response.dart';
import 'package:sakani_mobile_app/app/data/models/sample_download_response.dart';
import 'package:sakani_mobile_app/app/data/models/user_agreement_response.dart';
import 'package:sakani_mobile_app/app/utils/app_permission_handler.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';

import 'repository/downloadable_prod_repository.dart';

class DownloadableProductController extends BaseController {
  final DownloadableProdRepository _repository = DownloadableProdRepository();

  DownloadableProductData? productData;

  @override
  void onInit() {
    super.onInit();
    fetchDownloadableProducts();
  }

  fetchDownloadableProducts() async {
    setBusy(true);
    SuccessOrError result = await _repository.fetchDownloadableProducts();
    if (result.success) {
      productData = result.response?.data;
      /*productData?.items = [
        DownloadableProductItem.fake(),
        DownloadableProductItem.fake(),
        DownloadableProductItem.fake(),
        DownloadableProductItem.fake(),
      ];*/
      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void downloadFile(String guid, String consent) async {
    // sampleDownloadSink.add(ApiResponse.loading());
    // try {
    // SuccessOrError response = await _repository.downloadFile(guid, consent);
    //   if (response.jsonResponse?.data?.hasUserAgreement == true) {
    //     fetchUserAgreementText(guid);
    //   } else {
    //     sampleDownloadSink.add(ApiResponse.completed(response));
    //   }
    // } catch (e) {
    //   sampleDownloadSink.add(ApiResponse.error(e.toString()));
    //   print(e.toString());
    // }

    bool status = await AppPermissionsHandler.storagePermission();
    if (status == false) {
      buildInfoSnack(
        msg: AppStrings.manageExternalStorageExplain.translate,
      );
      return;
    }

    showProgressDialog();
    SuccessOrError result = await _repository.downloadFile(guid, consent);
    hideProgressDialog();
    if (result.success) {
      FileResponse response = result.response?.data;
      FileDownloadResponse<SampleDownloadResponse> responseData =
          await response.responseData;
      if (responseData.jsonResponse?.data?.hasUserAgreement == true) {
        await fetchUserAgreementText(guid);
      } else {
        handelDownloadFileResponse(response);
      }
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  fetchUserAgreementText(String guid) async {
    showProgressDialog();
    SuccessOrError result = await _repository.fetchUserAgreementText(guid);
    hideProgressDialog();
    if (result.success) {
      UserAgreementData userAgreementData = result.response?.data;
      showUserAgreementDialog(userAgreementData);
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void showUserAgreementDialog(UserAgreementData? data) {
    Get.dialog(
      AlertDialog(
        title: Text(
          ConstStrings.DOWNLOADABLE_USER_AGREEMENT.translate,
        ),
        content: Text(data?.userAgreementText ?? ''),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              downloadFile(data?.orderItemGuid ?? '', 'true');
            },
            child: Text(
              ConstStrings.DOWNLOADABLE_I_AGREE.translate,
            ),
          ),
        ],
      ),
    );
  }
}
