import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sakani/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani/app/core/language_and_localization/app_strings.dart';
import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/models/file_download_response.dart';
import 'package:sakani/app/data/models/order_details_response.dart';
import 'package:sakani/app/modules/all_cart_modules/shopping_cart_page/shopping_cart_view.dart';
import 'package:sakani/app/modules/checkout_page/checkout_shared_mixin.dart';
import 'package:sakani/app/modules/checkout_page/widgets/checkout_web_view/arguments/checkout_web_view_argument.dart';
import 'package:sakani/app/modules/checkout_page/widgets/checkout_web_view/checkout_web_view.dart';
import 'package:sakani/app/modules/orders_pages/repository/order_repository.dart';
import 'package:sakani/app/modules/products_details_screen/products_details_view.dart';
import 'package:sakani/app/modules/tabs_screen/tabs_screen_view.dart';
import 'package:sakani/app/utils/app_permission_handler.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';
import '../../products_details_screen/arguments/product_details_screen_arguments.dart';

class OrderDetailsController extends BaseController {
  final OrderRepository _repository = OrderRepository();

  int? orderId;

  @override
  void onInit() {
    super.onInit();
    orderId = int.tryParse(Get.parameters['order_id'] ?? '');
    if (orderId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buildErrorSnackBar(msg: 'Order id is missing.');
        Get.back();
      });
      return;
    } else {
      fetchOrderDetails();
    }
  }

  OrderDetailsData? orderDetailsData;
  int pdfLinkSink = -1;

  fetchOrderDetails() async {
    setBusy(true);
    SuccessOrError result = await _repository.fetchOrderDetails(orderId!);
    if (result.success) {
      orderDetailsData = result.response?.data;
      pdfLinkSink = (orderDetailsData?.pdfInvoiceDisabled ?? false)
          ? -1
          : (orderDetailsData?.id ?? -1);
      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  reorder(int orderId) async {
    showProgressDialog();
    SuccessOrError result = await _repository.reorder(orderId);
    hideProgressDialog();
    if (result.success) {
      // go to cart
      Get.offNamedUntil(
        ShoppingCartPage.routeName,
        (route) =>
            route.isFirst || route.settings.name == TabsScreenView.routeName,
      );
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  repostPayment(int orderId) async {
    showProgressDialog();
    SuccessOrError result = await _repository.repostPayment(orderId);
    hideProgressDialog();
    if (result.success) {
      // open web view
      Get.toNamed(
        CheckoutWebViewStep.routeName,
        parameters: CheckoutWebViewArgument(
          action: CheckoutSteps.retryPayment.serverValue,
          screenTitle: ConstStrings.ONLINE_PAYMENT.translate,
          orderId: orderId,
        ).toJson(),
      )?.then((value) {
        // refresh page contents
        fetchOrderDetails();
      });
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  downloadPdfInvoice({required int orderId}) async {

    bool status = await AppPermissionsHandler.storagePermission();
    if (status == false) {
      buildInfoSnack(
        msg: AppStrings.manageExternalStorageExplain.translate,
      );
      return;
    }

    showProgressDialog();
    SuccessOrError result = await _repository.downloadPdfInvoice(orderId);
    hideProgressDialog();
    if (result.success) {
      FileResponse response = result.response?.data;
      handelDownloadFileResponse(response);
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  downloadNotesAttachment(int noteId) async {
    bool status = await AppPermissionsHandler.storagePermission();
    if (status == false) {
      buildInfoSnack(
        msg: AppStrings.manageExternalStorageExplain.translate,
      );
      return;
    }

    showProgressDialog();
    SuccessOrError result = await _repository.downloadNotesAttachment(noteId);
    hideProgressDialog();
    if (result.success) {
      FileResponse response = result.response?.data;
      handelDownloadFileResponse(response);
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void navigateToProductDetails(Item? item) {
    if (item != null && item.productId != null) {
      Get.toNamed(
          ProductsDetailsPage.navToRoute(
            item.productId!.toString(),
          ),
          parameters: ProductDetailsScreenArguments(
            id: item.productId!,
            name: item.productName ?? '',
          ).toJson());
    }
  }
}
