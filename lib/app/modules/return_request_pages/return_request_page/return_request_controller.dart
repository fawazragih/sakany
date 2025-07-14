import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani_mobile_app/app/data/models/requestbody/form_value.dart';
import 'package:sakani_mobile_app/app/modules/return_request_pages/repository/return_request_repository.dart';
import 'package:sakani_mobile_app/app/utils/api_env_config/app_logger_config.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';

import '../../../data/api_providers/base_configs/handling_dio_response.dart';
import '../../../data/models/file_upload_response.dart';
import '../../../data/models/requestbody/return_request_body.dart';
import '../../../data/models/return_request_response.dart';

class ReturnRequestController extends BaseController {
  final ReturnRequestRepository _repository = ReturnRequestRepository();

  int? orderId = -1;


  ReturnRequestData? returnRequestData;

  AvailableReturn? selectedAction, selectedReason;
  Map<int, int> quantityMap = {};
  String fileGuid = '';
  String selectedFileName = '';

  @override
  void onInit() {
    super.onInit();
    super.onInit();
    orderId = int.tryParse(Get.parameters['order_id'] ?? '');
    if (orderId == null || orderId == -1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buildErrorSnackBar(msg: 'Order id is missing.');
        Get.back();
      });
      return;
    } else {
      fetchReturnRequestFormData(orderId!);
    }
  }

  void fetchReturnRequestFormData(int orderId) async {
    // formSink.add(ApiResponse.loading());
    //
    // try {
    //   ReturnRequestResponse response = await _repository.fetchReturnRequestForm(orderId);
    //
    //   // add primary selected items
    //   selectedAction = AvailableReturn(
    //       id: -1, name: GlobalService().getString(Const.RETURN_REQ_ACTION));
    //
    //   selectedReason = AvailableReturn(
    //       id: -1, name: GlobalService().getString(Const.RETURN_REQ_REASON));
    //
    //   response.data?.availableReturnActions?.insertAll(0, [selectedAction!]);
    //   response.data?.availableReturnReasons?.insertAll(0, [selectedReason!]);
    //   response.data?.returnRequestReasonId = -1;
    //   response.data?.returnRequestActionId = -1;
    //
    //   response.data?.items?.forEach((element) {
    //     if (element.id != null) {
    //       quantityMap[element.id!] = 0;
    //     }
    //   });
    //
    //   formSink.add(ApiResponse.completed(response.data));
    // } catch (e) {
    //   formSink.add(ApiResponse.error(e.toString()));
    //   print(e);
    // }

    setBusy(true);
    SuccessOrError result = await _repository.fetchReturnRequestForm(orderId);
    if (result.success) {
      returnRequestData = result.response?.data;


      returnRequestData?.items?.forEach((element) {
        if (element.id != null) {
          quantityMap[element.id!] = 0;
        }
      });

      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void submitForm() async {
    ReturnRequestData? data = returnRequestData;
    if (formKey.currentState?.validate() ?? false) {
      if (data == null || data.orderId == null) {
        logger.e('Order id is missing.');
        return;
      }

      showProgressDialog();

      var reqBody = ReturnRequestBody(data: data, formValues: []);
      quantityMap.forEach((key, value) {
        if (value > 0) {
          reqBody.formValues?.add(FormValue(
            key: 'quantity$key',
            value: value.toString(),
          ));
        }
      });

      if (fileGuid.isNotEmpty) reqBody.data?.uploadedFileGuid = fileGuid;

      SuccessOrError result = await _repository.postReturnRequestForm(
        data.orderId!,
        reqBody,
      );
      hideProgressDialog();
      if (result.success) {
        ReturnRequestData response = result.response?.data;
        if (response.result?.isNotEmpty == true) {
          buildSuccessSnackBar(
            msg: response.result.translate ?? '',
          );
        }
        // refresh previous screen
        Get.back(result: true);
      } else {
        buildErrorSnackBar(msg: result.error.toString());
      }
    }
  }

  void uploadFile(String filePath) async {
    showProgressDialog();
    SuccessOrError result = await _repository.uploadFile(filePath);
    hideProgressDialog();
    if (result.success) {
      FileUploadData data = result.response?.data;
      fileGuid = data.downloadGuid ?? '';
      buildSuccessSnackBar(
        msg: ConstStrings.COMMON_DONE.translate,
      );
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }
}
