
import 'shopping_cart_response.dart';

class PostCheckoutAttrResponse {
  PostCheckoutAttrResponse({
    this.cart,
    this.orderTotals,
    this.selectedCheckoutAttributess,
    this.enabledAttributeIds,
    this.disabledAttributeIds
  });

  Cart? cart;
  OrderTotals? orderTotals;
  String? selectedCheckoutAttributess;
  List<dynamic>? enabledAttributeIds;
  List<dynamic>? disabledAttributeIds;

  factory PostCheckoutAttrResponse.fromJson(Map<String, dynamic> json) => PostCheckoutAttrResponse(
    cart: json["Cart"] == null ? null : Cart.fromJson(json["Cart"]),
    orderTotals: json["OrderTotals"] == null ? null : OrderTotals.fromJson(json["OrderTotals"]),
    selectedCheckoutAttributess: json["SelectedCheckoutAttributess"],
        enabledAttributeIds: json["EnabledAttributeIds"] == null
            ? null
            : List<dynamic>.from(json["EnabledAttributeIds"]!.map((x) => x)),
        disabledAttributeIds: json["DisabledAttributeIds"] == null
            ? null
            : List<dynamic>.from(json["DisabledAttributeIds"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Cart": cart?.toJson(),
        "OrderTotals": orderTotals?.toJson(),
        "SelectedCheckoutAttributess": selectedCheckoutAttributess,
        "EnabledAttributeIds": enabledAttributeIds == null
            ? null
            : List<dynamic>.from(enabledAttributeIds!.map((x) => x)),
        "DisabledAttributeIds": disabledAttributeIds == null
            ? null
            : List<dynamic>.from(disabledAttributeIds!.map((x) => x)),
      };
}