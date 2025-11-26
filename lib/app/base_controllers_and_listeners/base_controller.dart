import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import 'package:tamoily/app/base_controllers_and_listeners/shared_repository.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../core/language_and_localization/app_strings.dart';
import '../data/api_providers/base_configs/handling_dio_response.dart';
import '../data/local_data/setting_app_service.dart';
import '../data/models/app_landing_response.dart';
import '../data/models/available_option.dart';
import '../data/models/file_download_response.dart';
import '../data/models/get_states_response.dart';
import '../data/models/sample_download_response.dart';
import '../global_widget/app_ui_helper/different_dialogs.dart';
import '../modules/auth_module/login_screen/login_view.dart';
import '../modules/tabs_screen/tabs_screen_view.dart';
import '../utils/constants/const_strings.dart';
import '../utils/file_utils/adutil_file.dart';
import '../utils/url_launcher_manager.dart';
import 'helpers_methods.dart';
import 'user_auth_controller.dart';

class BaseController extends GetxController with HelpersMethods {
  static final GlobalKey<ScaffoldState> _tabScreenScaffoldKey =
      GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get tabScreenScaffoldKey => _tabScreenScaffoldKey;

  //region state and formKey

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  GlobalKey<FormBuilderState> get formKey {
    return _formKey;
  }

  ///.....
  bool _busy = false;

  bool get busy => _busy;

  // RetryFailedListener failedListener;

  void setBusy(bool value, {bool notify = true}) {
    if (value && _showRetryButton) {
      _showRetryButton = false;
    }
    _busy = value;
    if (notify) {
      update();
    }
  }

  //retry setting;
  bool _showRetryButton = false;
  String? errorMessage;

  bool get showRetryButton => _showRetryButton;

  setShowRetryButton(bool value, {String? errorMsg}) {
    if (value && _busy) {
      _busy = false;
    }
    _showRetryButton = value;
    errorMessage = _showRetryButton ? errorMsg : null;
    update();
  }

  //endregion

  /// .......................................................................
  void navBackUntilPathOrHome({String? path}) {
    // var d = Get.routeTree.routes.map((e) =>'${e.name}=> ${e.participatesInRootNavigator}').toList();
    // logger.d(d.toString());

    return Get.until(
        (route) => route.settings.name == (path ?? TabsScreenView.routeName));
  }

  /// .......................................................................
  //region CurrentUserData
  UserAuthController get userAuthController => Get.find<UserAuthController>();

  //endregion

  //region
  AppSettingService get appSettingService => Get.find<AppSettingService>();

  AppLandingData? get appLandingData => appSettingService.appLandingData;

  //endregion

  /// .......................................................................

  //region search widget code

  clearFilter(VoidCallback onClear) {
    _query = null;
    onClear.call();
    hideSoftKeyBoard();
  }

  final _debounce = Debouncer(
    delay: const Duration(seconds: 1),
  );

  String? _query;

  onQuerySearchChange(String? value, ValueChanged<String?> startSearching) {
    _query = value;
    _debounce.call(
      () async {
        // if (_query != null && _query!.isNotEmpty && _query!.length >= 2) {
        //   startSearching.call(_query);
        // } else {
        //   _query = null;
        // }
        startSearching.call(_query);
      },
    );
  }

  bool showRestFilterButton = false;

  //endregion of search widget code

//region logout
  logout() async {
    var res = await DifferentDialogs.openConfirmationDialog(
      headerIconData: CupertinoIcons.square_arrow_right,
      // okBgColor: Get.theme.dividerColor,
      // cancelBgColor: Get.theme.primaryColorLight,
      descMessage: AppStrings.areYouSureYouWantToLogOut.tr.capitalizeFirst!,
      // okTextColor: Get.theme.disabledColor,
    );

    if (res == true) {
      await userAuthController.signUserOut();
      // Get.offNamedUntil(LoginScreen.routeName, ModalRoute.withName('/home'));
      Get.offNamedUntil(
        LoginScreen.routeName,
        (route) => route.settings.name == TabsScreenView.routeName,
      );
    }
  }

  //endregion

  //region States logic
  RxBool loadingStates = RxBool(false);
  RxList<AvailableOption> statesList = RxList();

  fetchStates(int countryId) async {
    // int countryId = int.tryParse(country.value ?? '') ?? -1;

    if (countryId == -1) return;
    loadingStates.value = true;

    SuccessOrError response =
        await SharedRepository().getStatesByCountry(countryId);
    loadingStates.value = false;
    if (response.success) {
      List<AvailableStates> availableStates = response.response?.data ?? [];
      statesList.value = availableStates
          .map((e) => AvailableOption(text: e.name, value: e.id.toString()))
          .toList();
    } else {
      buildErrorSnackBar(msg: response.error.toString());
    }
  }

  //endregion

//region Download file logic
  handelDownloadFileResponse(FileResponse response) async {
    FileDownloadResponse<SampleDownloadResponse> data =
        await response.responseData;

    if (data.file != null) {
      await AdUtilFiles.saveFileToDisk(response);
      buildInfoSnack(msg: ConstStrings.FILE_DOWNLOADED.translate);
    } else if (data.jsonResponse?.data?.downloadUrl != null) {
      UrlLauncherManager.openUrlLink(
        urlLink: data.jsonResponse!.data!.downloadUrl!,
      );
    }
  }
//endregion
}
