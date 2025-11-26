import 'dart:ui';

import 'package:tamoily/app/core/language_and_localization/languages_list.dart';

import 'custom_properties.dart';

class AppLandingData {
  bool? showHomepageSlider;
  bool? showFeaturedProducts;
  bool? sliderAutoPlay;
  int? sliderAutoPlayTimeout;
  bool? showBestsellersOnHome;
  bool? showHomepageCategoryProducts;
  bool? showManufacturers;
  bool? rtl;
  String? androidVersion;
  bool? andriodForceUpdate;
  String? playStoreUrl;
  String? iOSVersion;
  bool? iOSForceUpdate;
  String? appStoreUrl;
  String? logoUrl;
  int? totalShoppingCartProducts;
  int? totalWishListProducts;
  bool? showAllVendors;
  bool? anonymousCheckoutAllowed;
  bool? showChangeBaseUrlPanel;
  bool? hasReturnRequests;
  bool? hideDownloadableProducts;
  String? primaryThemeColor;
  String? topBarBackgroundColor;
  String? topBarTextColor;
  String? bottomBarBackgroundColor;
  String? bottomBarActiveColor;
  String? bottomBarInactiveColor;
  String? gradientStartingColor;
  String? gradientMiddleColor;
  String? gradientEndingColor;
  bool? gradientEnabled;
  int? iOSProductPriceTextSize;
  int? androidProductPriceTextSize;
  int? ionicProductPriceTextSize;
  bool? newProductsEnabled;
  bool? recentlyViewedProductsEnabled;
  bool? compareProductsEnabled;
  bool? allowCustomersToUploadAvatars;
  int? avatarMaximumSizeBytes;
  bool? hideBackInStockSubscriptionsTab;
  bool? storeClosed;
  bool? rewardPointsEnabled;
  bool? showProductReviewsTabOnAccountPage;
  CurrencyNavSelector? currencyNavSelector;
  LanguageNavSelector? languageNavSelector;
  List<StringResources>? stringResources;
  bool? allowCustomersToDeleteAccount;
  bool isDefault;

  AppLandingData({
    this.isDefault = false,
    this.showHomepageSlider,
    this.showFeaturedProducts,
    this.sliderAutoPlay,
    this.sliderAutoPlayTimeout,
    this.showBestsellersOnHome,
    this.showHomepageCategoryProducts,
    this.showManufacturers,
    this.rtl,
    this.androidVersion,
    this.andriodForceUpdate,
    this.playStoreUrl,
    this.iOSVersion,
    this.iOSForceUpdate,
    this.appStoreUrl,
    this.logoUrl,
    this.totalShoppingCartProducts,
    this.totalWishListProducts,
    this.showAllVendors,
    this.anonymousCheckoutAllowed,
    this.showChangeBaseUrlPanel,
    this.hasReturnRequests,
    this.hideDownloadableProducts,
    this.primaryThemeColor,
    this.topBarBackgroundColor,
    this.topBarTextColor,
    this.bottomBarBackgroundColor,
    this.bottomBarActiveColor,
    this.bottomBarInactiveColor,
    this.gradientStartingColor,
    this.gradientMiddleColor,
    this.gradientEndingColor,
    this.gradientEnabled,
    this.iOSProductPriceTextSize,
    this.androidProductPriceTextSize,
    this.ionicProductPriceTextSize,
    this.newProductsEnabled,
    this.recentlyViewedProductsEnabled,
    this.compareProductsEnabled,
    this.allowCustomersToUploadAvatars,
    this.avatarMaximumSizeBytes,
    this.hideBackInStockSubscriptionsTab,
    this.storeClosed,
    this.currencyNavSelector,
    this.languageNavSelector,
    this.stringResources,
    this.allowCustomersToDeleteAccount,
    this.rewardPointsEnabled,
    this.showProductReviewsTabOnAccountPage,
  });

  Map<String, String?>? _translateMap;

  Map<String, String?> get translateMap {
    if (_translateMap != null) {
      return _translateMap!;
    }

    List<MapEntry<String, String?>> d =
        stringResources?.map((e) => e.toMapEntry()).toList() ?? [];

    _translateMap = Map.fromEntries(d);
    return _translateMap!;
  }

  bool get checkShowProductReviewsTabOnAccountPage =>
      showProductReviewsTabOnAccountPage == null ||
      showProductReviewsTabOnAccountPage == true;

  bool get checkShowRewardPointsEnabled =>
      rewardPointsEnabled == null || rewardPointsEnabled == true;

  factory AppLandingData.fromJson(Map<String, dynamic> json) {
    List<StringResources> stringResources = <StringResources>[];

    if (json['StringResources'] != null) {
      json['StringResources'].forEach((v) {
        stringResources.add(StringResources.fromJson(v));
      });
    }
    return AppLandingData(
      // isDefault: false,
      showHomepageSlider: json['ShowHomepageSlider'],
      showFeaturedProducts: json['ShowFeaturedProducts'],
      sliderAutoPlay: json['SliderAutoPlay'],
      sliderAutoPlayTimeout: json['SliderAutoPlayTimeout'],
      showBestsellersOnHome: json['ShowBestsellersOnHomepage'],
      showHomepageCategoryProducts: json['ShowHomepageCategoryProducts'],
      showManufacturers: json['ShowManufacturers'],
      rtl: json['Rtl'],
      androidVersion: json['AndroidVersion'],
      andriodForceUpdate: json['AndriodForceUpdate'],
      playStoreUrl: json['PlayStoreUrl'],
      iOSVersion: json['IOSVersion'],
      iOSForceUpdate: json['IOSForceUpdate'],
      appStoreUrl: json['AppStoreUrl'],
      logoUrl: json['LogoUrl'],
      totalShoppingCartProducts: json['TotalShoppingCartProducts'],
      totalWishListProducts: json['TotalWishListProducts'],
      showAllVendors: json['ShowAllVendors'],
      anonymousCheckoutAllowed: json['AnonymousCheckoutAllowed'],
      showChangeBaseUrlPanel: json['ShowChangeBaseUrlPanel'],
      hasReturnRequests: json['HasReturnRequests'],
      hideDownloadableProducts: json['HideDownloadableProducts'],
      primaryThemeColor: json['PrimaryThemeColor'],
      topBarBackgroundColor: json['TopBarBackgroundColor'],
      topBarTextColor: json['TopBarTextColor'],
      bottomBarBackgroundColor: json['BottomBarBackgroundColor'],
      bottomBarActiveColor: json['BottomBarActiveColor'],
      bottomBarInactiveColor: json['BottomBarInactiveColor'],
      gradientStartingColor: json['GradientStartingColor'],
      gradientMiddleColor: json['GradientMiddleColor'],
      gradientEndingColor: json['GradientEndingColor'],
      gradientEnabled: json['GradientEnabled'],
      iOSProductPriceTextSize: json['IOSProductPriceTextSize'],
      androidProductPriceTextSize: json['AndroidProductPriceTextSize'],
      ionicProductPriceTextSize: json['IonicProductPriceTextSize'],
      newProductsEnabled: json['NewProductsEnabled'],
      recentlyViewedProductsEnabled: json['RecentlyViewedProductsEnabled'],
      compareProductsEnabled: json['CompareProductsEnabled'],
      allowCustomersToUploadAvatars: json['AllowCustomersToUploadAvatars'],
      avatarMaximumSizeBytes: json['AvatarMaximumSizeBytes'],
      hideBackInStockSubscriptionsTab: json['HideBackInStockSubscriptionsTab'],
      storeClosed: json["StoreClosed"],
      rewardPointsEnabled: json['RewardPointsEnabled'],
      showProductReviewsTabOnAccountPage:
          json['ShowProductReviewsTabOnAccountPage'],
      currencyNavSelector: json['CurrencyNavSelector'] != null
          ? CurrencyNavSelector.fromJson(json['CurrencyNavSelector'])
          : null,
      languageNavSelector: json['LanguageNavSelector'] != null
          ? LanguageNavSelector.fromJson(json['LanguageNavSelector'])
          : null,
      allowCustomersToDeleteAccount: json['AllowCustomersToDeleteAccount'],
      stringResources: stringResources,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ShowHomepageSlider'] = showHomepageSlider;
    data['ShowFeaturedProducts'] = showFeaturedProducts;
    data['SliderAutoPlay'] = sliderAutoPlay;
    data['SliderAutoPlayTimeout'] = sliderAutoPlayTimeout;
    data['ShowBestsellersOnHomepage'] = showBestsellersOnHome;
    data['ShowHomepageCategoryProducts'] = showHomepageCategoryProducts;
    data['ShowManufacturers'] = showManufacturers;
    data['Rtl'] = rtl;
    data['AndroidVersion'] = androidVersion;
    data['AndriodForceUpdate'] = andriodForceUpdate;
    data['PlayStoreUrl'] = playStoreUrl;
    data['IOSVersion'] = iOSVersion;
    data['IOSForceUpdate'] = iOSForceUpdate;
    data['AppStoreUrl'] = appStoreUrl;
    data['LogoUrl'] = logoUrl;
    data['TotalShoppingCartProducts'] = totalShoppingCartProducts;
    data['TotalWishListProducts'] = totalWishListProducts;
    data['ShowAllVendors'] = showAllVendors;
    data['AnonymousCheckoutAllowed'] = anonymousCheckoutAllowed;
    data['ShowChangeBaseUrlPanel'] = showChangeBaseUrlPanel;
    data['HasReturnRequests'] = hasReturnRequests;
    data['HideDownloadableProducts'] = hideDownloadableProducts;
    data['PrimaryThemeColor'] = primaryThemeColor;
    data['TopBarBackgroundColor'] = topBarBackgroundColor;
    data['TopBarTextColor'] = topBarTextColor;
    data['BottomBarBackgroundColor'] = bottomBarBackgroundColor;
    data['BottomBarActiveColor'] = bottomBarActiveColor;
    data['BottomBarInactiveColor'] = bottomBarInactiveColor;
    data['GradientStartingColor'] = gradientStartingColor;
    data['GradientMiddleColor'] = gradientMiddleColor;
    data['GradientEndingColor'] = gradientEndingColor;
    data['GradientEnabled'] = gradientEnabled;
    data['IOSProductPriceTextSize'] = iOSProductPriceTextSize;
    data['AndroidProductPriceTextSize'] = androidProductPriceTextSize;
    data['IonicProductPriceTextSize'] = ionicProductPriceTextSize;
    data['NewProductsEnabled'] = newProductsEnabled;
    data['RecentlyViewedProductsEnabled'] = recentlyViewedProductsEnabled;
    data['CompareProductsEnabled'] = compareProductsEnabled;
    data['AllowCustomersToUploadAvatars'] = allowCustomersToUploadAvatars;
    data['AvatarMaximumSizeBytes'] = avatarMaximumSizeBytes;
    data['HideBackInStockSubscriptionsTab'] = hideBackInStockSubscriptionsTab;
    data['StoreClosed'] = storeClosed;
    data['RewardPointsEnabled'] = rewardPointsEnabled;
    data['ShowProductReviewsTabOnAccountPage'] =
        showProductReviewsTabOnAccountPage;
    if (currencyNavSelector != null) {
      data['CurrencyNavSelector'] = currencyNavSelector?.toJson();
    }
    if (languageNavSelector != null) {
      data['LanguageNavSelector'] = languageNavSelector?.toJson();
    }
    if (stringResources != null) {
      data['StringResources'] =
          stringResources!.map((v) => v.toJson()).toList();
    }
    data['AllowCustomersToDeleteAccount'] = allowCustomersToDeleteAccount;
    return data;
  }
}

class CurrencyNavSelector {
  List<AvailableCurrencies>? availableCurrencies;
  int? currentCurrencyId;
  CustomProperties? customProperties;

  CurrencyNavSelector(
      {this.availableCurrencies,
      this.currentCurrencyId,
      this.customProperties});

  CurrencyNavSelector.fromJson(Map<String, dynamic> json) {
    if (json['AvailableCurrencies'] != null) {
      availableCurrencies = <AvailableCurrencies>[];
      json['AvailableCurrencies'].forEach((v) {
        availableCurrencies?.add(AvailableCurrencies.fromJson(v));
      });
    }
    currentCurrencyId = json['CurrentCurrencyId'];
    customProperties = json['CustomProperties'] != null
        ? CustomProperties.fromJson(json['CustomProperties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (availableCurrencies != null) {
      data['AvailableCurrencies'] =
          availableCurrencies!.map((v) => v.toJson()).toList();
    }
    data['CurrentCurrencyId'] = currentCurrencyId;
    if (customProperties != null) {
      data['CustomProperties'] = customProperties?.toJson();
    }
    return data;
  }
}

class AvailableCurrencies {
  String? name;
  String? currencySymbol;
  int? id;
  CustomProperties? customProperties;

  AvailableCurrencies(
      {this.name, this.currencySymbol, this.id, this.customProperties});

  AvailableCurrencies.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    currencySymbol = json['CurrencySymbol'];
    id = json['Id'];
    customProperties = json['CustomProperties'] != null
        ? CustomProperties.fromJson(json['CustomProperties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['CurrencySymbol'] = currencySymbol;
    data['Id'] = id;
    if (customProperties != null) {
      data['CustomProperties'] = customProperties?.toJson();
    }
    return data;
  }
}

class LanguageNavSelector {
  List<AvailableLanguages>? availableLanguages;
  int? currentLanguageId;
  bool? useImages;
  CustomProperties? customProperties;

  LanguageNavSelector(
      {this.availableLanguages,
      this.currentLanguageId,
      this.useImages,
      this.customProperties});

  LanguageNavSelector.fromJson(Map<String, dynamic> json) {
    if (json['AvailableLanguages'] != null) {
      availableLanguages = <AvailableLanguages>[];
      json['AvailableLanguages'].forEach((v) {
        availableLanguages?.add(AvailableLanguages.fromJson(v));
      });
    }
    currentLanguageId = json['CurrentLanguageId'];
    useImages = json['UseImages'];
    customProperties = json['CustomProperties'] != null
        ? CustomProperties.fromJson(json['CustomProperties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (availableLanguages != null) {
      data['AvailableLanguages'] =
          availableLanguages!.map((v) => v.toJson()).toList();
    }
    data['CurrentLanguageId'] = currentLanguageId;
    data['UseImages'] = useImages;
    if (customProperties != null) {
      data['CustomProperties'] = customProperties?.toJson();
    }
    return data;
  }
}

class AvailableLanguages {
  String? name;
  String? flagImageFileName;
  int? id;
  CustomProperties? customProperties;

  AvailableLanguages({
    this.name,
    this.flagImageFileName,
    this.id,
    this.customProperties,
  });

  AvailableLanguages.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    flagImageFileName = json['FlagImageFileName'];
    id = json['Id'];
    customProperties = json['CustomProperties'] != null
        ? CustomProperties.fromJson(json['CustomProperties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['FlagImageFileName'] = flagImageFileName;
    data['Id'] = id;
    if (customProperties != null) {
      data['CustomProperties'] = customProperties?.toJson();
    }
    return data;
  }

  AppLanguage toAppLanguage() {
    return AppLanguage(
      id ?? 0,
      name ?? '',
      Locale(name ?? ''),
    );
  }
}

class StringResources {
  String? key;
  String? value;

  StringResources({this.key, this.value});

  StringResources.fromJson(Map<String, dynamic> json) {
    key = json['Key'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    return {
      'Key': key,
      'Value': value,
    };
  }

  MapEntry<String, String?> toMapEntry() => MapEntry(key ?? '', value);
}
