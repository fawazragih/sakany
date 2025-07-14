import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/models/file_download_response.dart';
import 'package:sakani/app/data/models/file_upload_response.dart';
import 'package:sakani/app/data/models/product_attr_change_response.dart';
import 'package:sakani/app/data/models/product_details_response.dart';
import 'package:sakani/app/data/models/product_summary.dart';
import 'package:sakani/app/data/models/requestbody/form_value.dart';
import 'package:sakani/app/data/models/requestbody/form_values_request_body.dart';
import 'package:sakani/app/data/models/subscription_status_response.dart';
import 'package:sakani/app/global_widget/app_ui_helper/app_fancy_dialog.dart';
import 'package:sakani/app/global_widget/app_ui_helper/different_dialogs.dart';
import 'package:sakani/app/modules/products_details_screen/arguments/product_details_screen_arguments.dart';
import 'package:sakani/app/utils/constants/app_constants.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';
import 'package:sakani/app/utils/nop_custom_attribute_manager/custom_attribute_manager.dart';
import 'package:sakani/app/utils/api_env_config/app_logger_config.dart';
import '../../base_controllers_and_listeners/base_controller.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../data/models/BaseResponse.dart';
import '../../data/models/available_option.dart';
import '../../utils/app_permission_handler.dart';
import '../all_cart_modules/shopping_cart_page/shopping_cart_view.dart';
import 'repository/all_products_repository.dart';

class ProductsDetailsController extends BaseController {
  final AllProductsRepository _repository = AllProductsRepository();

  late int productId;
  ProductDetailsScreenArguments? arguments;
  ProductDetails? productDetails;

  late CustomAttributeManager attributeManager;
  DateTime? rentalStartDate, rentalEndDate;
  AvailableOption? selectedQuantity;
  String selectedShippingMethod = '';

  bool? updateCart;

  int? updateCartItemId;

  @override
  void onInit() {
    super.onInit();
    arguments = ProductDetailsScreenArguments.fromJson(Get.parameters);
    productId = int.tryParse(
            Get.parameters['product_id'] ?? arguments?.id?.toString() ?? '') ??
        -1;
    // productId = 37;
    if (productId == -1) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Get.back();
        buildErrorSnackBar(msg: 'product_id mus be passed');
      });
      return;
    }
    updateCart = arguments?.updateCart;
    updateCartItemId = arguments?.updateCartItemId;

    fetchProductDetails();
    fetchRelatedProducts(productId);
    fetchCrossSellProducts(productId);

    ///
    attributeManager = CustomAttributeManager(
      context: Get.context,
      onClick: (priceAdjNeeded) {
        postSelectedAttributes(
          productId,
          attributeManager
              .getSelectedAttributes(AppConstants.productAttributePrefix),
        );
      },
      onFileSelected: (file, attributeId) {
        if (file.path != null) _uploadFile(file.path!, attributeId);
      },
    );
  }

  fetchProductDetails() async {
    setBusy(true);
    SuccessOrError result = await _repository.fetchProductDetails(
      productId: productId,
      updateCart: updateCart ?? false,
      updateCartItemId: updateCartItemId,
    );
    if (result.success) {
      productDetails = result.response?.data;
      selectedQuantity =
          productDetails?.addToCart?.allowedQuantities?.firstOrNull;

      // _cachedProductDetails = response.data;
      /// add product to recently viewed list
      // if (response.data != null) {
      //   GlobalService().addToRecentlyViewedProduct(response.data!);
      // }

      /// pre-selected attributes
      List<FormValue> preselectedAttributes = [];
      productDetails?.productAttributes?.forEach((attribute) {
        attribute.values?.forEach((element) {
          if (element.isPreSelected == true) {
            preselectedAttributes.add(FormValue(
              key:
                  '${AppConstants.productAttributePrefix}_${attribute.id.toString()}',
              value: element.id.toString(),
            ));
          }
        });
      });

      logger.d(
          'preselectedAttributes=> ${preselectedAttributes.map((e) => e.toJson())}');

      if (preselectedAttributes.isNotEmpty) {
        await postSelectedAttributes(productId, preselectedAttributes,
            showLoader: false);
      }
      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  Future<void> postSelectedAttributes(
    int productId,
    List<FormValue> formValues, {
    bool showLoader = true,
  }) async {
    // logger.d('postSelectedAttributes');
    if (formValues.isEmpty) {
      return;
    }

    if (showLoader) {
      showProgressDialog();
    }

    formValues.add(FormValue(
      key: 'ValidateAttributeConditions',
      value: 'true',
    ));
    formValues.add(FormValue(
      key: 'LoadPicture',
      value: 'true',
    ));

    SuccessOrError result = await _repository.postSelectedAttributes(
      productId: productId,
      formValuesRequestBody: FormValuesRequestBody(formValues: formValues),
    );

    // logger.d(result.toJson);

    if (result.success) {
      ProductAttrChangeData response = result.response?.data;
      updatePrice(response);
      updateProductImage(response);
      if (showLoader) {
        update();
        hideProgressDialog();
      }
    } else {
      if (showLoader) {
        hideProgressDialog();
      }
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  RxList<ProductSummary> relatedProductList = RxList([]);

  void fetchRelatedProducts(int productId) async {
    SuccessOrError result =
        await _repository.fetchRelatedProducts(productId: productId);

    if (result.success) {
      relatedProductList.value = result.response?.data;
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  RxList<ProductSummary> crossSellList = RxList([]);

  void fetchCrossSellProducts(int productId) async {
    SuccessOrError result =
        await _repository.fetchCrossSellProducts(productId: productId);
    if (result.success) {
      crossSellList.value = result.response?.data;
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  addToCart({
    int? productId,
    required int cartType,
    required ProductDetails product,
    required List<FormValue> formValues,
    bool? updateCart,
    int? updateCartItemId,
    required bool redirectToCart,
  }) async {
    if (productId == null) {
      return;
    }

    // loaderSink.add(true);
    // append product related form values (gift card info, rental product info...)
    // with product attributes form values
    formValues
        .addAll(getProductFormValues(product, updateCart, updateCartItemId));

    // addToCartSink.add(ApiResponse.loading());

    // setBusy(true);
    showProgressDialog();
    SuccessOrError result = await _repository.addToCart(
      productId: productId,
      cartType: cartType,
      requestBody: FormValuesRequestBody(formValues: formValues),
    );
    hideProgressDialog();
    if (result.success) {
      toastMessage(result.response?.message ??AppStrings.successfullyDone.translate);
      if (redirectToCart) Get.toNamed(ShoppingCartPage.routeName);
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void getSubscriptionStatus(int productId) async {
    // subStatusSink.add(ApiResponse.loading());
    showProgressDialog();
    SuccessOrError result =
        await _repository.fetchSubscriptionStatus(productId: productId);
    hideProgressDialog();
    if (result.success) {
      SubscriptionStatusResponseData subStatusResult = result.response?.data;
      if (subStatusResult.alreadySubscribed != null &&
          subStatusResult.productId != null) {
        showSubscriptionPopup(
          subStatusResult.alreadySubscribed!,
          subStatusResult.productId!,
        );
      }
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void showSubscriptionPopup(bool isSubscribed, int productId) {
    Get.dialog(
      AppFancyDialog(
          title: isSubscribed
              ? ConstStrings
                  .BACK_IN_STOCK_POPUP_TITLE_ALREADY_SUBSCRIBED.translate
              : ConstStrings.BACK_IN_STOCK_POPUP_TITLE.translate,
          positiveButtonText: isSubscribed
              ? ConstStrings.BACK_IN_STOCK_UNSUBSCRIBED.translate
              : ConstStrings.BACK_IN_STOCK_NOTIFY_ME.translate,
          onPositive: () async {
            if (Get.isDialogOpen == true) {
              Get.back(result: true);
            }
            changeSubscriptionStatus(productId);
          }),
    );
  }

  changeSubscriptionStatus(int productId) async {
    showProgressDialog();
    SuccessOrError result =
        await _repository.changeSubscriptionStatus(productId: productId);
    hideProgressDialog();
    if (result.success) {
      BaseResponse response = result.response?.data;
      buildSuccessSnackBar(msg: response.message);
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  // ProductDetails? _cachedProductDetails;

  //TODO byMw check upload file
  void _uploadFile(String filePath, int attributeId) async {
    // fileUploadSink.add(ApiResponse.loading());

    logger.d('message');

    DifferentDialogs.showProgressDialog();
    await Future.delayed(Duration(seconds: 1));
    DifferentDialogs.hideProgressDialog();
    return;
    SuccessOrError result = await _repository.uploadFile(
        filePath: filePath, attributeId: attributeId.toString());
    logger.d(result.toJson);
    DifferentDialogs.hideProgressDialog();
    if (result.success) {
      FileUploadData response = result.response?.data;
      response.attributedId = attributeId;
      if (response.attributedId != null && response.downloadGuid != null) {
        attributeManager.addUploadedFileGuid(
            response.attributedId!, response.downloadGuid!);
      }
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }

    // try {
    //   FileUploadResponse response = await _repository.uploadFile(filePath, attributeId.toString());
    //   FileUploadData uploadFileData = response.data;
    //   uploadFileData?.attributedId = attributeId;
    //   fileUploadSink.add(ApiResponse.completed(uploadFileData));
    // } catch (e) {
    //   fileUploadSink.add(ApiResponse.error(e.toString()));
    //   debugPrint(e.toString());
    // }

    /*
    _bloc.fileUploadStream.listen((event) {
      if (event.status == Status.COMPLETED) {
        DialogBuilder(context).hideLoader();

        if (event.data?.attributedId != null &&
            event.data?.downloadGuid != null) {
          attributeManager.addUploadedFileGuid(
              event.data!.attributedId!, event.data!.downloadGuid!);
        }
      } else if (event.status == Status.ERROR) {
        DialogBuilder(context).hideLoader();
        showSnackBar(context, event.message ?? '', true);
      } else if (event.status == Status.LOADING) {
        DialogBuilder(context).showLoader();
      }
    });
    */
  }

  //TODO byMw check downloadSample file

  void downloadSample(int productId) async {
    bool status = await AppPermissionsHandler.storagePermission();
    if (status == false) {
      buildInfoSnack(
        msg: AppStrings.manageExternalStorageExplain.translate,
      );
      return;
    }

    SuccessOrError result =
        await _repository.downloadSample(productId: productId);
    if (result.success) {
      FileResponse response = result.response?.data;
      handelDownloadFileResponse(response);
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
    // sampleDownloadSink.add(ApiResponse.loading());
    // logger.d(productId);
    // try {
    //   FileDownloadResponse<SampleDownloadResponse> response =
    //       await _repository.downloadSample(productId);
    //   sampleDownloadSink.add(ApiResponse.completed(response));
    // } catch (e) {
    //   sampleDownloadSink.add(ApiResponse.error(e.toString()));
    //   logger.e(e.toString());
    // }

    /*
    _bloc.sampleDownloadStream.listen((event) {
      if (event.status == Status.COMPLETED) {
        DialogBuilder(context).hideLoader();

        if (event.data?.file != null) {
          showSnackBar(
              context, _globalService.getString(Const.FILE_DOWNLOADED), false);
        } else if (event.data?.jsonResponse?.data?.downloadUrl != null) {
          launchUrl(event.data!.jsonResponse!.data!.downloadUrl!);
        }
      } else if (event.status == Status.ERROR) {
        DialogBuilder(context).hideLoader();
        showSnackBar(context, event.message ?? '', true);
      } else if (event.status == Status.LOADING) {
        DialogBuilder(context).showLoader();
      }
    });
    */
  }

  List<FormValue> getProductFormValues(ProductDetails? product,
      [bool? updateCart, num? updateCartItemId]) {
    num? productId = product?.id;
    List<FormValue> formValues = [];

    // entered price
    if (product?.addToCart?.customerEntersPrice == true) {
      formValues.add(FormValue(
        key: 'addtocart_$productId.CustomerEnteredPrice',
        value: product?.addToCart?.customerEnteredPrice.toString(),
      ));
    } else {
      var quantity = selectedQuantity != null
          ? int.tryParse(selectedQuantity?.value ?? '1') ?? 1
          : product?.addToCart?.enteredQuantity ?? 1;
      if (updateCart ?? false) {
        formValues.add(
          FormValue(
            key: 'addtocart_$productId.UpdatedShoppingCartItemId',
            value: '$updateCartItemId',
          ),
        );
      } else {
        formValues.add(
          FormValue(
            key: 'addtocart_$productId.EnteredQuantity',
            value: '$quantity',
          ),
        );
      }
    }
    // gift card
    if (product?.giftCard?.isGiftCard == true) {
      formValues.add(FormValue(
        key: "giftcard_$productId.Message",
        value: '${product?.giftCard?.message}',
      ));
      formValues.add(FormValue(
        key: "giftcard_$productId.SenderName",
        value: '${product?.giftCard?.senderName}',
      ));
      formValues.add(FormValue(
        key: "giftcard_$productId.SenderEmail",
        value: '${product?.giftCard?.senderEmail}',
      ));
      formValues.add(FormValue(
        key: "giftcard_$productId.RecipientName",
        value: '${product?.giftCard?.recipientName}',
      ));
      formValues.add(FormValue(
        key: "giftcard_$productId.RecipientEmail",
        value: '${product?.giftCard?.recipientEmail}',
      ));
    }
    // rental date
    if (product?.isRental == true) {
      var formatter = DateFormat('MM/dd/yyyy');

      if (rentalStartDate != null) {
        formValues.add(FormValue(
          key: 'rental_start_date_${product?.id}',
          value: formatter.format(rentalStartDate ?? DateTime.now()),
        ));
      }

      if (rentalEndDate != null) {
        formValues.add(FormValue(
          key: 'rental_end_date_${product?.id} ',
          value: formatter.format(rentalEndDate ?? DateTime.now()),
        ));
      }
    }

    return formValues;
  }

  List<int> disabledAttributeIds = [];
  final GlobalKey<FormState> giftCardFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> rentalFormKey = GlobalKey<FormState>();

  void updatePrice(ProductAttrChangeData response) {
    productDetails?.isFreeShipping = response.isFreeShipping ?? false;
    productDetails?.productPrice?.price = response.price ?? '';
    productDetails?.gtin = response.gtin ?? '';
    productDetails?.sku = response.sku ?? '';
    productDetails?.stockAvailability = response.stockAvailability ?? '';
    productDetails?.defaultPictureModel?.fullSizeImageUrl =
        response.pictureFullSizeUrl ?? '';
    productDetails?.defaultPictureModel?.imageUrl =
        response.pictureDefaultSizeUrl ?? '';
    disabledAttributeIds = response.disabledAttributeMappingIds ?? [];
  }

  /// update image on slider based on selected product attributes
  void updateProductImage(ProductAttrChangeData response) {
    if (response.pictureDefaultSizeUrl?.isNotEmpty == true) {
      for (var i = 0; i < (productDetails?.pictureModels?.length ?? 0); i++) {
        final picModel = productDetails?.pictureModels?[i];

        if (picModel?.imageUrl == response.pictureDefaultSizeUrl) {
          // carouselIndex = i;
          // sliderCtrl.jumpToPage(i);
          break;
        }
      }
    }
  }

  addToCartClick({
    required int cartType,
    required bool redirectToCart,
  }) {
    hideSoftKeyBoard();
    // removeFocusFromInputField(context);

    String errMsg = attributeManager
        .checkRequiredAttributes(productDetails?.productAttributes ?? []);
    if (errMsg.isNotEmpty) {
      logger.d(errMsg);
      buildErrorSnackBar(msg: errMsg);
    } else {
      if (productDetails?.giftCard?.isGiftCard == true &&
          giftCardFormKey.currentState?.validate() == true) {
        giftCardFormKey.currentState?.save();
        addToCart(
          productId: productDetails?.id,
          cartType: cartType,
          product: productDetails!,
          formValues: attributeManager
              .getSelectedAttributes(AppConstants.productAttributePrefix),
          updateCart: updateCart,
          updateCartItemId: updateCartItemId,
          redirectToCart: redirectToCart,
        );
      }
      if (productDetails?.isRental == true &&
          rentalFormKey.currentState?.validate() == true) {
        rentalFormKey.currentState?.save();
        addToCart(
          productId: productDetails?.id,
          cartType: cartType,
          product: productDetails!,
          formValues: attributeManager
              .getSelectedAttributes(AppConstants.productAttributePrefix),
          updateCart: updateCart,
          updateCartItemId: updateCartItemId,
          redirectToCart: redirectToCart,
        );
      } else {
        if (productDetails?.giftCard?.isGiftCard == false) {
          addToCart(
            productId: productDetails?.id,
            cartType: cartType,
            product: productDetails!,
            formValues: attributeManager
                .getSelectedAttributes(AppConstants.productAttributePrefix),
            updateCart: updateCart,
            updateCartItemId: updateCartItemId,
            redirectToCart: redirectToCart,
          );
        }
      }
    }
  }

  bool get showPrice =>
      productDetails?.productPrice?.hidePrices == false &&
      productDetails?.addToCart?.customerEntersPrice == false &&
      productDetails?.productType != 10 &&
      productDetails?.productPrice != null;

  bool get showSampleDownloadBtn => productDetails?.hasSampleDownload == true;
}
