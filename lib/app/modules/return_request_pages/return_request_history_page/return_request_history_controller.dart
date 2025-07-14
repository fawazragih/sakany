import 'package:app_extensions/app_extensions.dart';
import 'package:sakani/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani/app/core/language_and_localization/app_strings.dart';
import 'package:sakani/app/data/models/file_download_response.dart';
import 'package:sakani/app/data/models/return_request_history_response.dart';
import 'package:sakani/app/modules/return_request_pages/repository/return_request_repository.dart';
import 'package:sakani/app/utils/app_permission_handler.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';

import '../../../data/api_providers/base_configs/handling_dio_response.dart';

class ReturnRequestHistoryController extends BaseController {
  final ReturnRequestRepository _repository = ReturnRequestRepository();

  ReturnReqHistoryData? historyData;

  void fetchReturnRequestHistory() async {
    // historySink.add(ApiResponse.loading());
    // try {
    //   ReturnReqHistoryResponse response =
    //       await _repository.fetchReturnRequestHistory();
    //   historySink.add(ApiResponse.completed(response.data));
    // } catch (e) {
    //   historySink.add(ApiResponse.error(e.toString()));
    //   print(e);
    // }
    setBusy(true);
    SuccessOrError result = await _repository.fetchReturnRequestHistory();
    if (result.success) {
      historyData = result.response?.data;
      /*historyData = ReturnReqHistoryData(
        items: [
          ReturnReqHistoryItem.fakeData(),
          ReturnReqHistoryItem.fakeData(),
        ],
      );*/
      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void downloadFile(String? fileGuid) async {
    // fileDownloadSink.add(ApiResponse.loading());
    //
    // try {
    //   FileDownloadResponse<SampleDownloadResponse> response =
    //       await _repository.downloadFile(fileGuid);
    //   fileDownloadSink.add(ApiResponse.completed(response));
    // } catch (e) {
    //   fileDownloadSink.add(ApiResponse.error(e.toString()));
    //   print(e.toString());
    // }

    if (fileGuid.isNullOrEmpty) {
      return;
    }

    bool status = await AppPermissionsHandler.storagePermission();
    if (status == false) {
      buildInfoSnack(
        msg: AppStrings.manageExternalStorageExplain.translate,
      );
      return;
    }

    showProgressDialog();
    SuccessOrError result = await _repository.downloadFile(fileGuid!);
    hideProgressDialog();
    if (result.success) {
      FileResponse response = result.response?.data;
      handelDownloadFileResponse(response);
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchReturnRequestHistory();
  }
}
