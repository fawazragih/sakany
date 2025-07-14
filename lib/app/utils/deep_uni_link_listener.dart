import 'dart:async';
import 'package:app_extensions/app_extensions.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sakani/app/modules/product_list_page/argument/product_list_argument.dart';
import 'package:sakani/app/modules/product_list_page/product_list_view.dart';
import '../core/language_and_localization/app_strings.dart';
import '../global_widget/app_ui_helper/different_dialogs.dart';
import '../modules/products_details_screen/products_details_view.dart';
import 'api_env_config/app_logger_config.dart';

enum DeepLinkType {
  productDetails('product_details'),
  category('category');

  final String valueFromBE;

  const DeepLinkType(this.valueFromBE);
}

class DeepUniLinkListener {
  // final AppStartApi _appStartApi = AppStartApi();

  DeepUniLinkListener._() {
    startHandleNav.listen((value) {
      // logger.i('startHandleNav=>${startHandleNav.value}');
      if (value) {
        _handleClickedLink();
      }
    });
  }

  static final DeepUniLinkListener _instance = DeepUniLinkListener._();

  static DeepUniLinkListener get instance => _instance;

  RxBool startHandleNav = RxBool(false);

  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  Uri? _initialAppLink;

  set initialAppLink(Uri? value) {
    _initialAppLink = value;
    if (startHandleNav.value) {
      _handleClickedLink();
    }
  }

  Future<void> init() async {
    _appLinks = AppLinks();
    // Check initial link if app was in cold state (terminated)
    initialAppLink = await _appLinks.getInitialLink();

    // _latestAppLink = await _appLinks.getLatestAppLink();
    logger.d('initialDeepAppLink: ${_initialAppLink?.toString()}');

    // Subscribe to all events when app is started.
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      logger.d('UriLink From Stream=> $uri');
      initialAppLink = uri;
    });
  }

  _handleClickedLink() async {
    if ((kIsWeb && kDebugMode) || _initialAppLink == null) {
      return;
    }
    // DifferentDialogs.toastMessage(message: 'start handle clicked link');
    // logger.d('start _handleClickedLink');

    ///... start get the token
    // logger.d(_initialAppLink!.pathSegments);
    var type = _initialAppLink!.pathSegments.firstOrNull;
    var id = _initialAppLink!.pathSegments.lastOrNull;
    logger.d('type is=>$type');
    logger.d('id is=>$type');

    if (type.isNotNullOrEmpty &&
        id.isNotNullOrEmpty &&
        int.tryParse(id ?? '') != null) {
      _getTokenInfoAndNavigateUser(type!, id!);
    }
    _initialAppLink = null;
  }

  _getTokenInfoAndNavigateUser(String type, String id) async {
    DifferentDialogs.showProgressDialog(
        // context: GlobalService().navigatorKey?.currentContext,
        );

    /// TODO
    /// start get info of token from backend
    await Future.delayed(const Duration(seconds: 5));

    // SuccessOrError result = await _appStartApi.getShareLinkInfo(token: token);
    DifferentDialogs.hideProgressDialog(
        // context: GlobalService().navigatorKey?.currentContext,
        );

    switch (type) {
      case '10':
        //show product details.
        Get.toNamed(
          ProductsDetailsPage.routeName,
          //TODO byMe pass as Map
          // arguments: ProductDetailsScreenArguments(
          //   id: int.tryParse(id),
          //   name: '',
          // ),
        );
        /*Navigator.pushNamed(
          GlobalService().navigatorKey!.currentContext!,
          ProductDetailsPage.routeName,
          arguments: ProductDetailsScreenArguments(
            id: int.tryParse(id),
            name: '',
          ),
        );*/
        break;
      case '20':
        //show category products.
        Get.toNamed(
          ProductListPage.navTo(id),
          parameters: ProductListScreenArguments(
            id: int.tryParse(id),
            // name: '',
            type: GetProductListBy.CATEGORY,
          ).toJson(),
        );
        /* Navigator.of(GlobalService().navigatorKey!.currentContext!).pushNamed(
          ProductListScreen.routeName,
          arguments: ProductListScreenArguments(
            id: int.tryParse(id),
            // name: '',
            type: GetBy.CATEGORY,
          ),
        );*/
        break;
      default:
        DifferentDialogs.toastMessage(
          message: AppStrings.updateAppToHandleThisProcess.tr.capitalizeFirst!,
        );
        break;
    }
  }

  void disposeUniLinkStreamSubscription() {
    if (_linkSubscription != null) {
      _linkSubscription?.cancel();
      _linkSubscription = null;
    }
  }
}
