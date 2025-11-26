import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:tamoily/app/modules/about_app_page/about_app_controller.dart';
import 'package:tamoily/app/modules/account_screen/account_page_controller.dart';
import 'package:tamoily/app/modules/address_list_page/add_or_edit_address_page/add_or_edit_address_controller.dart';
import 'package:tamoily/app/modules/address_list_page/add_or_edit_address_page/add_or_edit_address_view.dart';
import 'package:tamoily/app/modules/address_list_page/address_list_controller.dart';
import 'package:tamoily/app/modules/all_cart_modules/shopping_cart_page/shopping_cart_controller.dart';
import 'package:tamoily/app/modules/all_cart_modules/shopping_cart_page/shopping_cart_view.dart';
import 'package:tamoily/app/modules/all_categories_page/categories_controller.dart';
import 'package:tamoily/app/modules/all_manufacturers_page/all_manufacturers_controller.dart';
import 'package:tamoily/app/modules/all_manufacturers_page/all_manufacturers_view.dart';
import 'package:tamoily/app/modules/checkout_page/checkout_controller.dart';
import 'package:tamoily/app/modules/contact_us_page/contact_us_controller.dart';
import 'package:tamoily/app/modules/contact_us_page/contact_us_view.dart';
import 'package:tamoily/app/modules/customer_review_page/customer_review_controller.dart';
import 'package:tamoily/app/modules/customer_review_page/customer_review_view.dart';
import 'package:tamoily/app/modules/downloadable_product_page/downloadable_product_controller.dart';
import 'package:tamoily/app/modules/downloadable_product_page/downloadable_product_view.dart';
import 'package:tamoily/app/modules/error_screen/error_screen.dart';
import 'package:tamoily/app/modules/home_page/home_controller.dart';
import 'package:tamoily/app/modules/home_page/home_view.dart';
import 'package:tamoily/app/modules/intro_guides_page/intro_guides_controller.dart';
import 'package:tamoily/app/modules/intro_guides_page/intro_guides_view.dart';
import 'package:tamoily/app/modules/new_products_page/new_products_controller.dart';
import 'package:tamoily/app/modules/new_products_page/new_products_view.dart';
import 'package:tamoily/app/modules/orders_pages/order_details_page/order_details_controller.dart';
import 'package:tamoily/app/modules/orders_pages/order_details_page/order_details_view.dart';
import 'package:tamoily/app/modules/orders_pages/order_history_page/order_history_controller.dart';
import 'package:tamoily/app/modules/orders_pages/order_history_page/order_history_view.dart';
import 'package:tamoily/app/modules/product_list_page/product_list_view.dart';
import 'package:tamoily/app/modules/product_review_page/product_review_controller.dart';
import 'package:tamoily/app/modules/product_review_page/product_review_screen.dart';
import 'package:tamoily/app/modules/products_details_screen/products_details_controller.dart';
import 'package:tamoily/app/modules/return_request_pages/return_request_history_page/return_request_history_controller.dart';
import 'package:tamoily/app/modules/return_request_pages/return_request_history_page/return_request_history_view.dart';
import 'package:tamoily/app/modules/return_request_pages/return_request_page/return_request_view.dart';
import 'package:tamoily/app/modules/reward_point_page/reward_point_controller.dart';
import 'package:tamoily/app/modules/reward_point_page/reward_point_view.dart';
import 'package:tamoily/app/modules/search_page/search_controller.dart';
import 'package:tamoily/app/modules/store_closed_page/store_closed_controller.dart';
import 'package:tamoily/app/modules/subscription_page/subscription_controller.dart';
import 'package:tamoily/app/modules/subscription_page/subscription_view.dart';
import 'package:tamoily/app/modules/tabs_screen/tabs_screen_controller.dart';
import 'package:tamoily/app/modules/topic_page/topic_controller.dart';
import 'package:tamoily/app/modules/topic_page/topic_view.dart';
import 'package:tamoily/app/modules/user_profile_screen/update_user_profile_page/update_user_profile_controller.dart';
import 'package:tamoily/app/modules/user_profile_screen/update_user_profile_page/update_user_profile_view.dart';
import 'package:tamoily/app/modules/user_profile_screen/user_profile_controller.dart';
import 'package:tamoily/app/modules/vendors_pages/contact_vendor_page/contact_vendor_controller.dart';
import 'package:tamoily/app/modules/vendors_pages/contact_vendor_page/contact_vendor_view.dart';
import 'package:tamoily/app/modules/vendors_pages/vendor_list_page/vendor_list_controller.dart';
import 'package:tamoily/app/modules/wish_list_page/wish_list_view.dart';
import '../modules/about_app_page/about_app_view.dart';
import '../modules/address_list_page/address_list_view.dart';
import '../modules/app_media_viewer_screens/app_photo_viewer_screen/app_photo_viewer_controller.dart';
import '../modules/app_media_viewer_screens/app_photo_viewer_screen/app_photo_viewer_view.dart';
import '../modules/auth_module/forget_password_screen/forget_password_view.dart';
import '../modules/auth_module/login_screen/login_controller.dart';
import '../modules/auth_module/login_screen/login_view.dart';
import '../modules/auth_module/signup_screen/signup_controller.dart';
import '../modules/auth_module/signup_screen/signup_screen.dart';
import '../modules/checkout_page/checkout_view.dart';
import '../modules/error_screen/error_screen_controller.dart';
import '../modules/products_details_screen/products_details_view.dart';
import '../modules/return_request_pages/return_request_page/return_request_controller.dart';
import '../modules/splash_screen/splash_screen.dart';
import '../modules/store_closed_page/store_closed_view.dart';
import '../modules/tabs_screen/tabs_screen_view.dart';
import '../modules/user_profile_screen/user_profile_screen.dart';
import '../modules/vendors_pages/vendor_list_page/vendor_list_view.dart';
import '../modules/wish_list_page/wish_list_controller.dart';
import 'auth_middleware.dart';
import 'base_binding.dart';

class AppRoutsAndPages {
  static final List<GetPage> allRoutes = [
    /// essential route for most apps ...................
    GetPage(
      name: SplashPage.routeName,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: ErrorScreen.routeName,
      page: () => const ErrorScreen(),
      binding: BaseBinding<ErrorPageController>(() => ErrorPageController()),
    ),

    GetPage(
      name: IntroGuidesScreen.routeName,
      page: () => const IntroGuidesScreen(),
      binding:
          BaseBinding<IntroGuidesController>(() => IntroGuidesController()),
      middlewares: [AuthMiddleware()],
    ),

    //region auth routes
    GetPage(
      participatesInRootNavigator: true,
      name: LoginScreen.routeName,
      page: () => const LoginScreen(),
      binding: BaseBinding<LoginController>(() => LoginController()),
      middlewares: [AuthMiddleware()],
      children: [
        GetPage(
          name: SignupScreen.routeName.removeAppPath,
          page: () => const SignupScreen(),
          binding: BaseBinding<SignupController>(() => SignupController()),
          // curve: Curves.easeInOut,
          // transitionDuration: Duration(milliseconds: 500),
        ),
        GetPage(
          name: ForgetPasswordScreen.routeName.removeAppPath,
          page: () => const ForgetPasswordScreen(),
        ),
      ],
    ),
    //endregion

    GetPage(
      participatesInRootNavigator: true,
      name: TabsScreenView.routeName,
      page: () => const TabsScreenView(),
      bindings: [
        BaseBinding<TabsScreenController>(() => TabsScreenController()),
        BaseBinding<HomeController>(() => HomeController()),
        BaseBinding<AllCategoriesController>(() => AllCategoriesController()),
        BaseBinding<SearchPageController>(() => SearchPageController()),
        BaseBinding<AccountPageController>(() => AccountPageController()),
        BaseBinding<ShoppingCartController>(() => ShoppingCartController()),
        BaseBinding<UserProfileController>(() => UserProfileController()),
      ],
      middlewares: [AuthMiddleware()],
      children: [
        GetPage(
          name: UserProfilePage.routeName.removeAppPath,
          page: () => const UserProfilePage(),
          binding:
              BaseBinding<UserProfileController>(() => UserProfileController()),
        ),
        GetPage(
          name: HomePage.routeName.removeAppPath,
          page: () => const HomePage(),
          binding: BaseBinding<HomeController>(() => HomeController()),
        ),
        GetPage(
          name: UpdateUserProfilePage.routeName,
          page: () => const UpdateUserProfilePage(),
          binding: BaseBinding<UpdateUserProfileController>(
              () => UpdateUserProfileController()),
        ),
        // GetPage(
        //   name: SettingsScreenView.routeName,
        //   page: () => const SettingsScreenView(),
        // ),
        // GetPage(
        //   name: BiometricScreen.routeName,
        //   page: () => BiometricScreen(),
        // ),
        // GetPage(
        //   name: PdfReaderWidget.routeName,
        //   page: () => const PdfReaderWidget(),
        // ),

        // GetPage(
        //   name: BiometricView.routeName,
        //   page: () => const BiometricView(),
        //   binding: BiometricBinding(),
        // ),

        GetPage(
          name: ProductListPage.routeName.removeAppPath,
          page: () => const ProductListPage(),
          // binding: BaseBinding<ProductListController>(() => ProductListController()),
        ),
        GetPage(
          name: ProductsDetailsPage.routeName.removeAppPath,
          page: () => const ProductsDetailsPage(),
          binding: BaseBinding<ProductsDetailsController>(
              () => ProductsDetailsController()),
        ),
        GetPage(
          name: ShoppingCartPage.routeName.removeAppPath,
          page: () => const ShoppingCartPage(),
          binding: BaseBinding<ShoppingCartController>(
              () => ShoppingCartController()),
        ),
        GetPage(
          name: CheckoutPage.routeName.removeAppPath,
          page: () => const CheckoutPage(),
          binding: BaseBinding<CheckoutController>(() => CheckoutController()),
        ),
        GetPage(
          name: ProductReviewPage.routeName.removeAppPath,
          page: () => const ProductReviewPage(),
          binding: BaseBinding<ProductReviewController>(
              () => ProductReviewController()),
        ),
        GetPage(
          name: CustomerReviewPage.routeName.removeAppPath,
          page: () => const CustomerReviewPage(),
          binding: BaseBinding<CustomerReviewController>(
              () => CustomerReviewController()),
        ),
        GetPage(
          name: AllManufacturersPage.routeName.removeAppPath,
          page: () => const AllManufacturersPage(),
          binding: BaseBinding<AllManufacturersController>(
              () => AllManufacturersController()),
        ),
        /* GetPage(
          name: CurrenciesScreen.routeName.lastPath,
          page: () => const CurrenciesScreen(),
          binding: CurrenciesBinding(),
        ),*/
        GetPage(
          name: AboutAppPage.routeName.removeAppPath,
          page: () => const AboutAppPage(),
          binding: BaseBinding<AboutAppController>(() => AboutAppController()),
        ),
        GetPage(
          name: AppPhotoViewerPage.routeName.removeAppPath,
          page: () => const AppPhotoViewerPage(),
          binding: BaseBinding<AppPhotoViewerController>(
            () => AppPhotoViewerController(),
          ),
        ),
        GetPage(
          name: StoreClosedPage.routeName.removeAppPath,
          page: () => const StoreClosedPage(),
          binding: BaseBinding<StoreClosedController>(
            () => StoreClosedController(),
          ),
        ),
        GetPage(
          name: AddressListPage.routeName.removeAppPath,
          page: () => const AddressListPage(),
          binding: BaseBinding<AddressListController>(
            () => AddressListController(),
          ),
        ),
        GetPage(
          name: AddOrEditAddressPage.routeName.removeAppPath,
          page: () => const AddOrEditAddressPage(),
          binding: BaseBinding<AddOrEditAddressController>(
            () => AddOrEditAddressController(),
          ),
        ),

        GetPage(
          name: OrderHistoryPage.routeName.removeAppPath,
          page: () => const OrderHistoryPage(),
          binding: BaseBinding<OrderHistoryController>(
            () => OrderHistoryController(),
          ),
        ),
        GetPage(
          name: OrderDetailsPage.routeName.removeAppPath,
          page: () => const OrderDetailsPage(),
          binding: BaseBinding<OrderDetailsController>(
            () => OrderDetailsController(),
          ),
        ),
        GetPage(
          name: ReturnRequestHistoryPage.routeName.removeAppPath,
          page: () => const ReturnRequestHistoryPage(),
          binding: BaseBinding<ReturnRequestHistoryController>(
            () => ReturnRequestHistoryController(),
          ),
        ),
        GetPage(
          name: ReturnRequestPage.routeName.removeAppPath,
          page: () => const ReturnRequestPage(),
          binding: BaseBinding<ReturnRequestController>(
            () => ReturnRequestController(),
          ),
        ),
        GetPage(
          name: WishListPage.routeName.removeAppPath,
          page: () => const WishListPage(),
          binding: BaseBinding<WishListController>(
            () => WishListController(),
          ),
        ),
        GetPage(
          name: NewProductsPage.routeName.removeAppPath,
          page: () => const NewProductsPage(),
          binding: BaseBinding<NewProductsController>(
            () => NewProductsController(),
          ),
        ),
        GetPage(
          name: SubscriptionPage.routeName.removeAppPath,
          page: () => const SubscriptionPage(),
          binding: BaseBinding<SubscriptionController>(
            () => SubscriptionController(),
          ),
        ),
        GetPage(
          name: RewardPointPage.routeName.removeAppPath,
          page: () => const RewardPointPage(),
          binding: BaseBinding<RewardPointController>(
            () => RewardPointController(),
          ),
        ),
        GetPage(
          name: TopicPage.routeName.removeAppPath,
          page: () => const TopicPage(),
          binding: BaseBinding<TopicController>(
            () => TopicController(),
          ),
        ),
        GetPage(
          name: VendorListPage.routeName.removeAppPath,
          page: () => const VendorListPage(),
          binding: BaseBinding<VendorListController>(
            () => VendorListController(),
          ),
        ),
        GetPage(
          name: ContactVendorPage.routeName.removeAppPath,
          page: () => const ContactVendorPage(),
          binding: BaseBinding<ContactVendorController>(
            () => ContactVendorController(),
          ),
        ),
        GetPage(
          name: ContactUsPage.routeName.removeAppPath,
          page: () => const ContactUsPage(),
          binding: BaseBinding<ContactUsController>(
            () => ContactUsController(),
          ),
        ),
        GetPage(
          name: DownloadableProductPage.routeName.removeAppPath,
          page: () => const DownloadableProductPage(),
          binding: BaseBinding<DownloadableProductController>(
            () => DownloadableProductController(),
          ),
        ),
      ],
    ),
  ];
}

extension PathExten on String {
  String get removeAppPath {
    if (startsWith('/auth')) {
      return replaceFirst("/auth", "");
    }
    return replaceFirst("/app", "");
  }

  // String get lastPath {
  //   if (startsWith('/app/')) {
  //     var last = split("/").last;
  //     return "/$last";
  //   } else {
  //     return this;
  //   }
  // }

  String get removeParams {
    var last = split("/:").last;
    return replaceAll("/:$last", "");
  }
}

