import 'package:sakani_mobile_app/app/utils/type_conversion.dart';

class AddOrEditAddressPageArgs {
  final bool? isEditMode;
  final int? addressId;

  AddOrEditAddressPageArgs({
    required this.isEditMode,
    required this.addressId,
  });

  Map<String, String> toJson() {
    return {
      'isEditMode': isEditMode?.toString() ??'',
      'addressId': addressId?.toString()??'',
    };
  }

  factory AddOrEditAddressPageArgs.fromJson(Map<String, dynamic> json) {
    return AddOrEditAddressPageArgs(
      isEditMode: json['isEditMode']?.toString().valueTypeToBool,
      addressId: int.tryParse(json['addressId']?.toString() ?? ''),
    );
  }
}
