import 'package:app_extensions/app_extensions.dart';

import 'shopping_cart_response.dart';
import 'custom_properties.dart';
import 'get_billing_address_response.dart';
import 'gift_card.dart';

class OrderDetailsResponse {
  OrderDetailsResponse({
    this.data,
    this.message,
    this.errorList,
  });

  OrderDetailsData? data;
  String? message;
  List<String>? errorList;

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) =>
      OrderDetailsResponse(
        data: json["Data"] == null
            ? null
            : OrderDetailsData.fromJson(json["Data"]),
        message: json["Message"],
        errorList: json["ErrorList"] == null
            ? null
            : List<String>.from(json["ErrorList"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
        "Message": message,
        "ErrorList": errorList == null
            ? null
            : List<dynamic>.from(errorList!.map((x) => x)),
      };
}

class OrderDetailsData {
  OrderDetailsData({
    this.printMode,
    this.pdfInvoiceDisabled,
    this.customOrderNumber,
    this.createdOn,
    this.orderStatus,
    this.isReOrderAllowed,
    this.isReturnRequestAllowed,
    this.isShippable,
    this.pickupInStore,
    this.pickupAddress,
    this.shippingStatus,
    this.shippingAddress,
    this.shippingMethod,
    this.shipments,
    this.billingAddress,
    this.vatNumber,
    this.paymentMethod,
    this.paymentMethodStatus,
    this.canRePostProcessPayment,
    this.customValues,
    this.orderSubtotal,
    this.orderSubTotalDiscount,
    this.orderShipping,
    this.paymentMethodAdditionalFee,
    this.checkoutAttributeInfo,
    this.pricesIncludeTax,
    this.displayTaxShippingInfo,
    this.tax,
    this.taxRates,
    this.displayTax,
    this.displayTaxRates,
    this.orderTotalDiscount,
    this.redeemedRewardPoints,
    this.redeemedRewardPointsAmount,
    this.orderTotal,
    this.giftCards,
    this.showSku,
    this.items,
    this.orderNotes,
    this.showVendorName,
    this.id,
    this.customProperties,
  });

  bool? printMode;
  bool? pdfInvoiceDisabled;
  String? customOrderNumber;
  DateTime? createdOn;
  String? orderStatus;
  bool? isReOrderAllowed;
  bool? isReturnRequestAllowed;
  bool? isShippable;
  bool? pickupInStore;
  Address? pickupAddress;
  String? shippingStatus;
  Address? shippingAddress;
  String? shippingMethod;
  List<ShipmentItem>? shipments;
  Address? billingAddress;
  String? vatNumber;
  String? paymentMethod;
  String? paymentMethodStatus;
  bool? canRePostProcessPayment;
  CustomProperties? customValues;
  String? orderSubtotal;
  String? orderSubTotalDiscount;
  String? orderShipping;
  String? paymentMethodAdditionalFee;
  String? checkoutAttributeInfo;
  bool? pricesIncludeTax;
  bool? displayTaxShippingInfo;
  String? tax;
  List<TaxRate>? taxRates;
  bool? displayTax;
  bool? displayTaxRates;
  String? orderTotalDiscount;
  int? redeemedRewardPoints;
  String? redeemedRewardPointsAmount;
  String? orderTotal;
  List<GiftCard>? giftCards;
  bool? showSku;
  List<Item>? items;
  List<OrderNotes>? orderNotes;
  bool? showVendorName;
  int? id;
  CustomProperties? customProperties;

  bool get showShipmentInfo => shipments?.isNotNullOrEmpty == true;

  bool get showCheckoutAttributeInfo => checkoutAttributeInfo?.isNotNullOrEmpty == true;
  bool get showOrderNotes => orderNotes?.isNotEmpty ==
      true;

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) =>
      OrderDetailsData(
        printMode: json["PrintMode"],
        pdfInvoiceDisabled: json["PdfInvoiceDisabled"],
        customOrderNumber: json["CustomOrderNumber"],
        createdOn: json["CreatedOn"] == null
            ? null
            : DateTime.parse(json["CreatedOn"]),
        orderStatus: json["OrderStatus"],
        isReOrderAllowed: json["IsReOrderAllowed"],
        isReturnRequestAllowed: json["IsReturnRequestAllowed"],
        isShippable: json["IsShippable"],
        pickupInStore: json["PickupInStore"],
        pickupAddress: json["PickupAddress"] == null
            ? null
            : Address.fromJson(json["PickupAddress"]),
        shippingStatus: json["ShippingStatus"],
        shippingAddress: json["ShippingAddress"] == null
            ? null
            : Address.fromJson(json["ShippingAddress"]),
        shippingMethod: json["ShippingMethod"],
        shipments: json["Shipments"] == null
            ? null
            : List<ShipmentItem>.from(
                json["Shipments"]!.map((x) => ShipmentItem.fromJson(x))),
        billingAddress: json["BillingAddress"] == null
            ? null
            : Address.fromJson(json["BillingAddress"]),
        vatNumber: json["VatNumber"],
        paymentMethod: json["PaymentMethod"],
        paymentMethodStatus: json["PaymentMethodStatus"],
        canRePostProcessPayment: json["CanRePostProcessPayment"],
        customValues: json["CustomValues"] == null
            ? null
            : CustomProperties.fromJson(json["CustomValues"]),
        orderSubtotal: json["OrderSubtotal"],
        orderSubTotalDiscount: json["OrderSubTotalDiscount"],
        orderShipping: json["OrderShipping"],
        paymentMethodAdditionalFee: json["PaymentMethodAdditionalFee"],
        checkoutAttributeInfo: json["CheckoutAttributeInfo"],
        pricesIncludeTax: json["PricesIncludeTax"],
        displayTaxShippingInfo: json["DisplayTaxShippingInfo"],
        tax: json["Tax"],
        taxRates: json["TaxRates"] == null
            ? null
            : List<TaxRate>.from(
                json["TaxRates"]!.map((x) => TaxRate.fromJson(x))),
        displayTax: json["DisplayTax"],
        displayTaxRates: json["DisplayTaxRates"],
        orderTotalDiscount: json["OrderTotalDiscount"],
        redeemedRewardPoints: json["RedeemedRewardPoints"],
        redeemedRewardPointsAmount: json["RedeemedRewardPointsAmount"],
        orderTotal: json["OrderTotal"],
        giftCards: json["GiftCards"] == null
            ? null
            : List<GiftCard>.from(
                json["GiftCards"]!.map((x) => GiftCard.fromJson(x))),
        showSku: json["ShowSku"],
        items: json["Items"] == null
            ? null
            : List<Item>.from(json["Items"]!.map((x) => Item.fromJson(x))),
        orderNotes: json["OrderNotes"] == null
            ? null
            : List<OrderNotes>.from(
                json["OrderNotes"]!.map((x) => OrderNotes.fromJson(x))),
        showVendorName: json["ShowVendorName"],
        id: json["Id"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "PrintMode": printMode,
        "PdfInvoiceDisabled": pdfInvoiceDisabled,
        "CustomOrderNumber": customOrderNumber,
        "CreatedOn": createdOn?.toIso8601String(),
        "OrderStatus": orderStatus,
        "IsReOrderAllowed": isReOrderAllowed,
        "IsReturnRequestAllowed": isReturnRequestAllowed,
        "IsShippable": isShippable,
        "PickupInStore": pickupInStore,
        "PickupAddress": pickupAddress?.toJson(),
        "ShippingStatus": shippingStatus,
        "ShippingAddress": shippingAddress?.toJson(),
        "ShippingMethod": shippingMethod,
        "Shipments": shipments == null
            ? null
            : List<dynamic>.from(shipments!.map((x) => x.toJson())),
        "BillingAddress": billingAddress?.toJson(),
        "VatNumber": vatNumber,
        "PaymentMethod": paymentMethod,
        "PaymentMethodStatus": paymentMethodStatus,
        "CanRePostProcessPayment": canRePostProcessPayment,
        "CustomValues": customValues?.toJson(),
        "OrderSubtotal": orderSubtotal,
        "OrderSubTotalDiscount": orderSubTotalDiscount,
        "OrderShipping": orderShipping,
        "PaymentMethodAdditionalFee": paymentMethodAdditionalFee,
        "CheckoutAttributeInfo": checkoutAttributeInfo,
        "PricesIncludeTax": pricesIncludeTax,
        "DisplayTaxShippingInfo": displayTaxShippingInfo,
        "Tax": tax,
        "TaxRates": taxRates == null
            ? null
            : List<dynamic>.from(taxRates!.map((x) => x.toJson())),
        "DisplayTax": displayTax,
        "DisplayTaxRates": displayTaxRates,
        "OrderTotalDiscount": orderTotalDiscount,
        "RedeemedRewardPoints": redeemedRewardPoints,
        "RedeemedRewardPointsAmount": redeemedRewardPointsAmount,
        "OrderTotal": orderTotal,
        "GiftCards": giftCards == null
            ? null
            : List<dynamic>.from(giftCards!.map((x) => x.toJson())),
        "ShowSku": showSku,
        "Items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "OrderNotes": orderNotes == null
            ? null
            : List<dynamic>.from(orderNotes!.map((x) => x.toJson())),
        "ShowVendorName": showVendorName,
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };
}

class Item {
  Item({
    this.orderItemGuid,
    this.sku,
    this.productId,
    this.productName,
    this.productSeName,
    this.unitPrice,
    this.subTotal,
    this.quantity,
    this.attributeInfo,
    this.rentalInfo,
    this.vendorName,
    this.downloadId,
    this.licenseId,
    this.id,
    this.customProperties,
  });

  String? orderItemGuid;
  String? sku;
  int? productId;
  String? productName;
  String? productSeName;
  String? unitPrice;
  String? subTotal;
  int? quantity;
  String? attributeInfo;
  dynamic rentalInfo;
  String? vendorName;
  int? downloadId;
  int? licenseId;
  int? id;
  CustomProperties? customProperties;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        orderItemGuid: json["OrderItemGuid"],
        sku: json["Sku"],
        productId: json["ProductId"],
        productName: json["ProductName"],
        productSeName: json["ProductSeName"],
        unitPrice: json["UnitPrice"],
        subTotal: json["SubTotal"],
        quantity: json["Quantity"],
        attributeInfo: json["AttributeInfo"],
        rentalInfo: json["RentalInfo"],
        vendorName: json["VendorName"],
        downloadId: json["DownloadId"],
        licenseId: json["LicenseId"],
        id: json["Id"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "OrderItemGuid": orderItemGuid,
        "Sku": sku,
        "ProductId": productId,
        "ProductName": productName,
        "ProductSeName": productSeName,
        "UnitPrice": unitPrice,
        "SubTotal": subTotal,
        "Quantity": quantity,
        "AttributeInfo": attributeInfo,
        "RentalInfo": rentalInfo,
        "VendorName": vendorName,
        "DownloadId": downloadId,
        "LicenseId": licenseId,
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };
}

class OrderNotes {
  OrderNotes({
    this.createdOn,
    this.note,
    this.hasDownload,
    this.id,
  });

  String? createdOn;
  String? note;
  bool? hasDownload;
  int? id;

  factory OrderNotes.fromJson(Map<String, dynamic> json) => OrderNotes(
        createdOn: json["CreatedOn"],
        note: json["Note"],
        hasDownload: json["HasDownload"],
        id: json["Id"],
      );

  Map<String, dynamic> toJson() => {
        "CreatedOn": createdOn,
        "Note": note,
        "HasDownload": hasDownload,
        "Id": id,
      };
}

class ShipmentItem {
  ShipmentItem({
    this.deliveryDate,
    this.shippedDate,
    this.trackingNumber,
    this.id,
  });

  DateTime? deliveryDate;
  DateTime? shippedDate;
  String? trackingNumber;
  int? id;

  factory ShipmentItem.fromJson(Map<String, dynamic> json) => ShipmentItem(
        deliveryDate: json["DeliveryDate"] == null
            ? null
            : DateTime.parse(json["DeliveryDate"]),
        shippedDate: json["ShippedDate"] == null
            ? null
            : DateTime.parse(json["ShippedDate"]),
        trackingNumber: json["TrackingNumber"],
        id: json["Id"],
      );

  Map<String, dynamic> toJson() => {
        "DeliveryDate": deliveryDate?.toIso8601String(),
        "ShippedDate": shippedDate?.toIso8601String(),
        "TrackingNumber": trackingNumber,
        "Id": id,
      };
}
