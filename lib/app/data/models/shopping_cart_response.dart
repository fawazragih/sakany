
import 'available_option.dart';
import 'custom_attribute.dart';
import 'custom_properties.dart';
import 'estimate_shipping.dart';
import 'get_billing_address_response.dart';
import 'gift_card.dart';
import 'picture_model.dart';

// class ShoppingCartResponse {
//   ShoppingCartResponse({
//     this.data,
//     this.message,
//     this.errorList,
//   });
//
//   ShoppingCartData? data;
//
//   String? message;
//   List<String>? errorList;
//
//   factory ShoppingCartResponse.fromJson(Map<String, dynamic> json) => ShoppingCartResponse(
//     data: json["Data"] == null ? null : ShoppingCartData.fromJson(json["Data"]),
//     message: json["Message"],
//         errorList: json["ErrorList"] == null
//             ? null
//             : List<String>.from(json["ErrorList"]!.map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "Data": data?.toJson(),
//         "Message": message,
//         "ErrorList": errorList == null
//             ? null
//             : List<dynamic>.from(errorList!.map((x) => x)),
//       };
// }

class ShoppingCartData {
  ShoppingCartData({
    this.cart,
    this.orderTotals,
    this.selectedCheckoutAttributes,
    this.estimateShipping,
    this.anonymousPermissed
  });

  Cart? cart;
  OrderTotals? orderTotals;
  String? selectedCheckoutAttributes;
  EstimateShipping? estimateShipping;
  bool? anonymousPermissed;

  factory ShoppingCartData.fromJson(Map<String, dynamic> json) => ShoppingCartData(
      cart: json["Cart"] == null ? null : Cart.fromJson(json["Cart"]),
      orderTotals: json["OrderTotals"] == null ? null : OrderTotals.fromJson(json["OrderTotals"]),
      selectedCheckoutAttributes: json["SelectedCheckoutAttributes"],
      estimateShipping: json["EstimateShipping"] == null ? null : EstimateShipping.fromJson(json["EstimateShipping"]),
      anonymousPermissed: json["AnonymousPermissed"]
  );

  Map<String, dynamic> toJson() => {
        "Cart": cart?.toJson(),
        "OrderTotals": orderTotals?.toJson(),
        "SelectedCheckoutAttributes": selectedCheckoutAttributes,
        "EstimateShipping":
            estimateShipping?.toJson(),
        "AnonymousPermissed": anonymousPermissed
      };
}

class Cart {
  Cart({
    this.onePageCheckoutEnabled,
    this.showSku,
    this.showProductImages,
    this.isEditable,
    this.items,
    this.checkoutAttributes,
    this.warnings,
    this.minOrderSubtotalWarning,
    this.displayTaxShippingInfo,
    this.termsOfServiceOnShoppingCartPage,
    this.termsOfServiceOnOrderConfirmPage,
    this.termsOfServicePopup,
    this.discountBox,
    this.giftCardBox,
    this.orderReviewData,
    this.buttonPaymentMethodViewComponentNames,
    this.hideCheckoutButton,
    this.showVendorName,
    this.customProperties,
  });

  bool? onePageCheckoutEnabled;
  bool? showSku;
  bool? showProductImages;
  bool? isEditable;
  List<CartItem>? items;
  List<CustomAttribute>? checkoutAttributes;
  List<String>? warnings;
  String? minOrderSubtotalWarning;
  bool? displayTaxShippingInfo;
  bool? termsOfServiceOnShoppingCartPage;
  bool? termsOfServiceOnOrderConfirmPage;
  bool? termsOfServicePopup;
  DiscountBox? discountBox;
  GiftCardBox? giftCardBox;
  OrderReviewData? orderReviewData;
  List<dynamic>? buttonPaymentMethodViewComponentNames;
  bool? hideCheckoutButton;
  bool? showVendorName;
  CustomProperties? customProperties;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    onePageCheckoutEnabled: json["OnePageCheckoutEnabled"],
    showSku: json["ShowSku"],
    showProductImages: json["ShowProductImages"],
    isEditable: json["IsEditable"],
        items: json["Items"] == null
            ? null
            : List<CartItem>.from(
                json["Items"]!.map((x) => CartItem.fromJson(x))),
        checkoutAttributes: json["CheckoutAttributes"] == null
            ? null
            : List<CustomAttribute>.from(json["CheckoutAttributes"]!
                .map((x) => CustomAttribute.fromJson(x))),
        warnings: json["Warnings"] == null
            ? null
            : List<String>.from(json["Warnings"]!.map((x) => x)),
        minOrderSubtotalWarning: json["MinOrderSubtotalWarning"],
        displayTaxShippingInfo: json["DisplayTaxShippingInfo"],
    termsOfServiceOnShoppingCartPage: json["TermsOfServiceOnShoppingCartPage"],
    termsOfServiceOnOrderConfirmPage: json["TermsOfServiceOnOrderConfirmPage"],
    termsOfServicePopup: json["TermsOfServicePopup"],
    discountBox: json["DiscountBox"] == null ? null : DiscountBox.fromJson(json["DiscountBox"]),
    giftCardBox: json["GiftCardBox"] == null ? null : GiftCardBox.fromJson(json["GiftCardBox"]),
    orderReviewData: json["OrderReviewData"] == null ? null : OrderReviewData.fromJson(json["OrderReviewData"]),
        buttonPaymentMethodViewComponentNames:
            json["ButtonPaymentMethodViewComponentNames"] == null
                ? null
                : List<dynamic>.from(
                    json["ButtonPaymentMethodViewComponentNames"]!
                        .map((x) => x)),
        hideCheckoutButton: json["HideCheckoutButton"],
        showVendorName: json["ShowVendorName"],
    customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "OnePageCheckoutEnabled": onePageCheckoutEnabled,
    "ShowSku": showSku,
    "ShowProductImages": showProductImages,
    "IsEditable": isEditable,
        "Items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "CheckoutAttributes": checkoutAttributes == null
            ? null
            : List<dynamic>.from(checkoutAttributes!.map((x) => x.toJson())),
        "Warnings": warnings == null
            ? null
            : List<dynamic>.from(warnings!.map((x) => x)),
        "MinOrderSubtotalWarning": minOrderSubtotalWarning,
        "DisplayTaxShippingInfo": displayTaxShippingInfo,
    "TermsOfServiceOnShoppingCartPage": termsOfServiceOnShoppingCartPage,
    "TermsOfServiceOnOrderConfirmPage": termsOfServiceOnOrderConfirmPage,
    "TermsOfServicePopup": termsOfServicePopup,
        "DiscountBox": discountBox?.toJson(),
        "GiftCardBox": giftCardBox?.toJson(),
        "OrderReviewData":
            orderReviewData?.toJson(),
        "ButtonPaymentMethodViewComponentNames":
            buttonPaymentMethodViewComponentNames == null
                ? null
                : List<dynamic>.from(
                    buttonPaymentMethodViewComponentNames!.map((x) => x)),
        "HideCheckoutButton":
            hideCheckoutButton,
        "ShowVendorName": showVendorName,
        "CustomProperties":
            customProperties?.toJson(),
      };
}

class DiscountBox {
  DiscountBox({
    this.appliedDiscountsWithCodes,
    this.display,
    this.messages,
    this.isApplied,
    this.customProperties,
  });

  List<AppliedDiscountsWithCode>? appliedDiscountsWithCodes;
  bool? display;
  List<String>? messages;
  bool? isApplied;
  CustomProperties? customProperties;

  factory DiscountBox.fromJson(Map<String, dynamic> json) => DiscountBox(
        appliedDiscountsWithCodes: json["AppliedDiscountsWithCodes"] == null
            ? null
            : List<AppliedDiscountsWithCode>.from(
                json["AppliedDiscountsWithCodes"]!
                    .map((x) => AppliedDiscountsWithCode.fromJson(x))),
        display: json["Display"],
        messages: json["Messages"] == null
            ? null
            : List<String>.from(json["Messages"]!.map((x) => x)),
        isApplied: json["IsApplied"],
        customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
        "AppliedDiscountsWithCodes": appliedDiscountsWithCodes == null
            ? null
            : List<dynamic>.from(
                appliedDiscountsWithCodes!.map((x) => x.toJson())),
        "Display": display,
        "Messages": messages == null
            ? null
            : List<dynamic>.from(messages!.map((x) => x)),
        "IsApplied": isApplied,
        "CustomProperties":
            customProperties?.toJson(),
      };
}

class AppliedDiscountsWithCode {
  AppliedDiscountsWithCode({
    this.couponCode,
    this.id,
    this.customProperties,
  });

  String? couponCode;
  int? id;
  CustomProperties? customProperties;

  factory AppliedDiscountsWithCode.fromJson(Map<String, dynamic> json) => AppliedDiscountsWithCode(
    couponCode: json["CouponCode"],
    id: json["Id"],
    customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "CouponCode": couponCode,
    "Id": id,
        "CustomProperties":
            customProperties?.toJson(),
      };
}

class GiftCardBox {
  GiftCardBox({
    this.display,
    this.message,
    this.isApplied,
    this.customProperties,
  });

  bool? display;
  String? message;
  bool? isApplied;
  CustomProperties? customProperties;

  factory GiftCardBox.fromJson(Map<String, dynamic> json) => GiftCardBox(
    display: json["Display"],
    message: json["Message"],
    isApplied: json["IsApplied"],
    customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Display": display,
    "Message": message,
    "IsApplied": isApplied,
        "CustomProperties":
            customProperties?.toJson(),
      };
}

class CartItem {
  CartItem({
    this.sku,
    this.vendorName,
    this.picture,
    this.productId,
    this.productName,
    this.productSeName,
    this.unitPrice,
    this.subTotal,
    this.discount,
    this.maximumDiscountedQty,
    this.quantity,
    this.allowedQuantities,
    this.attributeInfo,
    this.recurringInfo,
    this.rentalInfo,
    this.allowItemEditing,
    this.disableRemoval,
    this.warnings,
    this.id,
    this.customProperties,
  });

  String? sku;
  String? vendorName;
  PictureModel? picture;
  int? productId;
  String? productName;
  String? productSeName;
  String? unitPrice;
  String? subTotal;
  String? discount;
  dynamic maximumDiscountedQty;
  int? quantity;
  List<AvailableOption>? allowedQuantities;
  String? attributeInfo;
  dynamic recurringInfo;
  dynamic rentalInfo;
  bool? allowItemEditing;
  bool? disableRemoval;
  List<String>? warnings;
  int? id;
  CustomProperties? customProperties;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    sku: json["Sku"],
    vendorName: json["VendorName"],
    picture: json["Picture"] == null ? null : PictureModel.fromJson(json["Picture"]),
    productId: json["ProductId"],
    productName: json["ProductName"],
    productSeName: json["ProductSeName"],
    unitPrice: json["UnitPrice"],
    subTotal: json["SubTotal"],
    discount: json["Discount"],
    maximumDiscountedQty: json["MaximumDiscountedQty"],
    quantity: json["Quantity"],
        allowedQuantities: json["AllowedQuantities"] == null
            ? null
            : List<AvailableOption>.from(json["AllowedQuantities"]!
                .map((x) => AvailableOption.fromJson(x))),
        attributeInfo:
            json["AttributeInfo"],
        recurringInfo: json["RecurringInfo"],
    rentalInfo: json["RentalInfo"],
    allowItemEditing: json["AllowItemEditing"],
    disableRemoval: json["DisableRemoval"],
        warnings: json["Warnings"] == null
            ? null
            : List<String>.from(json["Warnings"]!.map((x) => x)),
        id: json["Id"],
        customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Sku": sku,
    "VendorName": vendorName,
        "Picture": picture?.toJson(),
        "ProductId": productId,
        "ProductName": productName,
    "ProductSeName": productSeName,
    "UnitPrice": unitPrice,
    "SubTotal": subTotal,
    "Discount": discount,
    "MaximumDiscountedQty": maximumDiscountedQty,
    "Quantity": quantity,
        "AllowedQuantities": allowedQuantities == null
            ? null
            : List<dynamic>.from(allowedQuantities!.map((x) => x.toJson())),
        "AttributeInfo": attributeInfo,
        "RecurringInfo": recurringInfo,
    "RentalInfo": rentalInfo,
    "AllowItemEditing": allowItemEditing,
    "DisableRemoval": disableRemoval,
        "Warnings": warnings == null
            ? null
            : List<dynamic>.from(warnings!.map((x) => x)),
        "Id": id,
        "CustomProperties":
            customProperties?.toJson(),
      };
}

class OrderReviewData {
  OrderReviewData({
    this.display,
    this.billingAddress,
    this.isShippable,
    this.shippingAddress,
    this.selectedPickupInStore,
    this.pickupAddress,
    this.shippingMethod,
    this.paymentMethod,
    this.customValues,
    this.customProperties,
  });

  bool? display;
  Address? billingAddress;
  bool? isShippable;
  Address? shippingAddress;
  bool? selectedPickupInStore;
  Address? pickupAddress;
  String? shippingMethod;
  String? paymentMethod;
  CustomProperties? customValues;
  CustomProperties? customProperties;

  factory OrderReviewData.fromJson(Map<String, dynamic> json) => OrderReviewData(
    display: json["Display"],
    billingAddress: json["BillingAddress"] == null ? null : Address.fromJson(json["BillingAddress"]),
    isShippable: json["IsShippable"],
    shippingAddress: json["ShippingAddress"] == null ? null : Address.fromJson(json["ShippingAddress"]),
    selectedPickupInStore: json["SelectedPickupInStore"],
    pickupAddress: json["PickupAddress"] == null ? null : Address.fromJson(json["PickupAddress"]),
    shippingMethod: json["ShippingMethod"],
    paymentMethod: json["PaymentMethod"],
    customValues: json["CustomValues"] == null ? null : CustomProperties.fromJson(json["CustomValues"]),
    customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Display": display,
        "BillingAddress":
            billingAddress?.toJson(),
        "IsShippable": isShippable,
        "ShippingAddress":
            shippingAddress?.toJson(),
        "SelectedPickupInStore":
            selectedPickupInStore,
        "PickupAddress": pickupAddress?.toJson(),
        "ShippingMethod": shippingMethod,
        "PaymentMethod": paymentMethod,
        "CustomValues": customValues?.toJson(),
        "CustomProperties":
            customProperties?.toJson(),
      };
}

class OrderTotals {
  OrderTotals({
    this.isEditable,
    this.subTotal,
    this.subTotalDiscount,
    this.shipping,
    this.requiresShipping,
    this.selectedShippingMethod,
    this.hideShippingTotal,
    this.paymentMethodAdditionalFee,
    this.tax,
    this.taxRates,
    this.displayTax,
    this.displayTaxRates,
    this.giftCards,
    this.orderTotalDiscount,
    this.redeemedRewardPoints,
    this.redeemedRewardPointsAmount,
    this.willEarnRewardPoints,
    this.orderTotal,
    this.customProperties,
  });

  bool? isEditable;
  String? subTotal;
  String? subTotalDiscount;
  String? shipping;
  bool? requiresShipping;
  String? selectedShippingMethod;
  bool? hideShippingTotal;
  String? paymentMethodAdditionalFee;
  String? tax;
  List<TaxRate>? taxRates;
  bool? displayTax;
  bool? displayTaxRates;
  List<GiftCard>? giftCards;
  String? orderTotalDiscount;
  num? redeemedRewardPoints;
  String? redeemedRewardPointsAmount;
  num? willEarnRewardPoints;
  String? orderTotal;
  CustomProperties? customProperties;

  factory OrderTotals.fromJson(Map<String, dynamic> json) => OrderTotals(
        isEditable: json["IsEditable"],
        subTotal: json["SubTotal"],
    subTotalDiscount: json["SubTotalDiscount"],
    shipping: json["Shipping"],
    requiresShipping: json["RequiresShipping"],
    selectedShippingMethod: json["SelectedShippingMethod"],
    hideShippingTotal: json["HideShippingTotal"],
    paymentMethodAdditionalFee: json["PaymentMethodAdditionalFee"],
    tax: json["Tax"],
        taxRates: json["TaxRates"] == null
            ? null
            : List<TaxRate>.from(
                json["TaxRates"]!.map((x) => TaxRate.fromJson(x))),
        displayTax: json["DisplayTax"],
        displayTaxRates: json["DisplayTaxRates"],
        giftCards: json["GiftCards"] == null
            ? null
            : List<GiftCard>.from(
                json["GiftCards"]!.map((x) => GiftCard.fromJson(x))),
        orderTotalDiscount: json["OrderTotalDiscount"],
        redeemedRewardPoints: json["RedeemedRewardPoints"],
    redeemedRewardPointsAmount: json["RedeemedRewardPointsAmount"],
    willEarnRewardPoints: json["WillEarnRewardPoints"],
    orderTotal: json["OrderTotal"],
    customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "IsEditable": isEditable,
    "SubTotal": subTotal,
    "SubTotalDiscount": subTotalDiscount,
    "Shipping": shipping,
    "RequiresShipping": requiresShipping,
    "SelectedShippingMethod": selectedShippingMethod,
    "HideShippingTotal": hideShippingTotal,
    "PaymentMethodAdditionalFee": paymentMethodAdditionalFee,
    "Tax": tax,
        "TaxRates": taxRates == null
            ? null
            : List<dynamic>.from(taxRates!.map((x) => x.toJson())),
        "DisplayTax": displayTax,
        "DisplayTaxRates": displayTaxRates,
        "GiftCards": giftCards == null
            ? null
            : List<dynamic>.from(giftCards!.map((x) => x)),
        "OrderTotalDiscount":
            orderTotalDiscount,
        "RedeemedRewardPoints": redeemedRewardPoints,
    "RedeemedRewardPointsAmount": redeemedRewardPointsAmount,
    "WillEarnRewardPoints": willEarnRewardPoints,
    "OrderTotal": orderTotal,
        "CustomProperties":
            customProperties?.toJson(),
      };
}




class TaxRate {
  TaxRate({
    this.rate,
    this.value,
    this.customProperties,
  });

  String? rate;
  String? value;
  CustomProperties? customProperties;

  factory TaxRate.fromJson(Map<String, dynamic> json) => TaxRate(
    rate: json["Rate"],
    value: json["Value"],
    customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Rate": rate,
    "Value": value,
        "CustomProperties":
            customProperties?.toJson(),
      };
}


