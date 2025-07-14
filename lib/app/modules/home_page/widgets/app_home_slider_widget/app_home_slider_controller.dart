import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani_mobile_app/app/modules/product_list_page/argument/product_list_argument.dart';
import 'package:sakani_mobile_app/app/modules/product_list_page/product_list_view.dart';
import 'package:sakani_mobile_app/app/modules/products_details_screen/arguments/product_details_screen_arguments.dart';
import 'package:sakani_mobile_app/app/modules/products_details_screen/products_details_view.dart';
import 'package:sakani_mobile_app/app/modules/topic_page/arguments/topic_page_arguments.dart';
import 'package:sakani_mobile_app/app/modules/topic_page/topic_view.dart';
import '../../../../data/models/home_slider_response.dart';
import '../../repository/home_repository.dart';

class AppHomeSliderController extends BaseController {
  final HomeRepository _repository = HomeRepository.instance;
  HomeSliderData? homeSliderData;

  @override
  onInit() async {
    super.onInit();
    await fetchHomeBanners();
  }

  fetchHomeBanners() async {
    setBusy(true);
    // logger.d('showHomepageSlider=>${appLandingData?.showHomepageSlider}');
    if (appLandingData?.showHomepageSlider == true) {
      //fetch HomeBanners
      SuccessOrError result = await _repository.fetchHomePageSliders();
      // logger.d(result.toJson);
      if (result.success) {
        homeSliderData = result.response?.data;
      } else {
        buildErrorSnackBar(msg: result.error?.message);
      }
      setBusy(false);
    } else {
      // clear HomeBanners data;
      homeSliderData = null;
    }
  }

  onSliderImageClick(Sliders i) {
    switch (i.sliderType) {
      case SliderType.category:
        if (i.entityId != null) {
          Get.toNamed(
            ProductListPage.navTo(i.entityId.toString()),
            parameters: ProductListScreenArguments(
              type: GetProductListBy.CATEGORY,
              id: i.entityId!,
            ).toJson(),
          );
        }

        break;
      case SliderType.manufacturer:
        if (i.entityId != null) {
          Get.toNamed(
            ProductListPage.navTo(i.entityId.toString()),
            parameters: ProductListScreenArguments(
              type: GetProductListBy.MANUFACTURER,
              id: i.entityId!,
            ).toJson(),
          );
        }

        break;
      case SliderType.vendor:
        if (i.entityId != null) {
          Get.toNamed(
            ProductListPage.navTo(i.entityId.toString()),
            parameters: ProductListScreenArguments(
              type: GetProductListBy.VENDOR,
              id: i.entityId!,
            ).toJson(),
          );
        }

        break;
      case SliderType.product:
        if (i.entityId != null) {
          Get.toNamed(
            ProductsDetailsPage.navToRoute(i.entityId.toString()),
            parameters: ProductDetailsScreenArguments(
              id: i.entityId!,
              name: null,
            ).toJson(),
          );
        }

        break;
      case SliderType.topic:
        if (i.entityId != null) {
          Get.toNamed(
            TopicPage.routeName,
            parameters: TopicPageArguments(
              topicId: i.entityId!,
            ).toJson(),
          );
        }

        break;
      case null:
    }
  }
}
