class CustomProperties {
  String? customerBASAuthCode;
  String? orderPaymentInfoTempKey;

  CustomProperties({
    this.customerBASAuthCode,
    this.orderPaymentInfoTempKey,
  });

  factory CustomProperties.fromJson(Map<String, dynamic> json) {
    return CustomProperties(
      customerBASAuthCode: json['CustomerBASAuthCode'],
      orderPaymentInfoTempKey: json['OrderPaymentInfoTempKey'],
    );
  }

  factory CustomProperties.fake() {
    return CustomProperties(
      customerBASAuthCode: 'fake_customer_bas_auth_code',
      orderPaymentInfoTempKey: 'fake_order_payment_info_temp_key',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'CustomerBASAuthCode': customerBASAuthCode,
      'OrderPaymentInfoTempKey': orderPaymentInfoTempKey,
    }..removeWhere((key, value) => value == null);
  }

}

// class CustomProperties {
//   CustomProperties();
//
//   factory CustomProperties.fromJson(Map<String, dynamic> json) => CustomProperties(
//   );
//
//   Map<String, dynamic> toJson() => {
//   };
// }
//
//
// class CustomProperties {
//   CustomProperties();
//
//   factory CustomProperties.fromJson(Map<String, dynamic> json) => CustomProperties(
//   );
//
//   Map<String, dynamic> toJson() => {
//   };
// }