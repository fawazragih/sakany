// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:tamoily/app/data/models/get_billing_address_response.dart';
// import 'package:tamoily/app/data/models/save_billing_response.dart';
// import 'package:tamoily/app/global_widget/action_buttons/action_button.dart';
// import 'package:tamoily/app/global_widget/app_ui_helper/shared_style.dart';
// import 'package:tamoily/app/modules/checkout_page/checkout_controller.dart';
// import 'package:tamoily/app/utils/constants/const_strings.dart';
// import 'package:tamoily/app/utils/nop_custom_attribute_manager/custom_attribute_manager.dart';
// import 'package:tamoily/app/utils/nop_custom_attribute_manager/validation_mixin.dart';
// import '../../../global_widget/all_form_widgets/drop_down_menu_form_field_widget.dart';
// import 'billing_shipping_addresses/add_new_address_form.dart';
//
// class StepCheckoutAddress extends StatefulWidget {
//   final GetBillingData? billingData;
//   final CheckoutController controller;
//   final ShippingAddressModel? shippingAddress;
//
//   const StepCheckoutAddress({
//     super.key,
//     this.billingData,
//     this.shippingAddress,
//     required this.controller,
//   });
//
//   @override
//   State<StepCheckoutAddress> createState() => _StepCheckoutAddressState();
// }
//
// class _StepCheckoutAddressState extends State<StepCheckoutAddress>
//     with ValidationMixin {
//   // final GlobalService _globalService = GlobalService();
//   GetBillingData? billingData;
//
//   ShippingAddressModel? shippingAddress;
//   late CheckoutController controller;
//   late CustomAttributeManager attributeManager;
//   bool? isBillingAddress;
//   late GlobalKey<FormBuilderState> _formKey;
//   final GlobalKey<FormBuilderState> _billingFormKey =
//       GlobalKey<FormBuilderState>();
//   final GlobalKey<FormBuilderState> _shippingFormKey =
//       GlobalKey<FormBuilderState>();
//
//   var isSelected = [true, false];
//
//   @override
//   void initState() {
//     super.initState();
//     controller = widget.controller;
//     billingData = widget.billingData;
//     shippingAddress = widget.shippingAddress;
//
//     isBillingAddress = billingData != null;
//     _formKey = (isBillingAddress ?? false) ? _billingFormKey : _shippingFormKey;
//
//     if (isBillingAddress == false) {
//       controller.existingShippingAddress = [
//         ...shippingAddress?.existingAddresses ?? []
//       ];
//
//       controller.showNewShippingAddress = shippingAddress?.existingAddresses?.isEmpty == true;
//
//       controller.storePickup = false;
//       controller.selectedShippingAddress =
//           shippingAddress?.existingAddresses?.isNotEmpty == true
//               ? shippingAddress?.existingAddresses?.first
//               : null;
//
//       controller.pickupPointAddress = [
//         ...shippingAddress?.pickupPointsModel?.pickupPoints ?? []
//       ];
//       controller.selectedPickupAddress =
//           shippingAddress?.pickupPointsModel?.pickupPoints?.isNotEmpty == true
//               ? shippingAddress?.pickupPointsModel?.pickupPoints?.first
//               : null;
//
//       controller.selectedCountry =
//           shippingAddress?.shippingNewAddress?.availableCountries?.firstOrNull;
//     }
//
//     attributeManager = CustomAttributeManager(
//       context: context,
//       onClick: (priceAdjNeeded) {
//         setState(() {
//           // updating UI to show selected attribute values
//         });
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     isSelected[0] = billingData != null;
//     isSelected[1] = shippingAddress != null;
//
//     Widget temp;
//
//     // TODO save first billing address & goto save shipping step
//     // billingData.disableBillingAddressCheckoutStep == true &&
//     //     billingData.billingAddress?.existingAddresses?.isNotEmpty == true
//
//     if (isBillingAddress ==true) {
//       temp = Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (billingData?.billingAddress?.shipToSameAddressAllowed == true)
//             CheckboxListTile(
//               value: controller.shipToSameAddress,
//               title: Text(ConstStrings.SHIP_TO_SAME_ADDRESS.translate),
//               onChanged: (bool? isSelected) {
//                 setState(() {
//                   controller.shipToSameAddress = isSelected;
//                 });
//               },
//             ),
//           AppDropDownMenuFormFieldWidget<Address?>(
//             keyName: ConstStrings.NEW_ADDRESS,
//             initialValue: controller.existingBillingAddress?[0],
//             hintText: ConstStrings.NEW_ADDRESS,
//             itemsList: controller.existingBillingAddress ?? [],
//             getItemName: (value) =>
//                 '${value?.firstName ?? ''} ${value?.lastName ?? ''}, ${value?.city ?? ''} ${value?.countryName ?? ''}',
//             onChanged: (value) {
//               setState(() {
//                 controller.showNewBillingAddress = value?.id == -1;
//                 controller.selectedBillingAddress = value;
//               });
//             },
//           ),
//           if ((controller.showNewBillingAddress ?? false) &&
//               billingData?.billingAddress?.billingNewAddress != null)
//             NewAddressForm(
//               formKey: _formKey,
//               bloc: controller,
//               attributeManager: attributeManager,
//               formData: billingData!.billingAddress!.billingNewAddress!,
//               onSubmit: () {},
//             ),
//           const SizedBox(height: 12),
//           ActionButton(
//             text: ConstStrings.CONTINUE.translate.toUpperCase(),
//             onPressed: () {
//               if ((controller.selectedBillingAddress?.id ?? -1) != -1) {
//                 controller.saveBillingAddress(newAddress: false);
//               } else {
//                 // form validation
//                 if (_formKey.currentState?.validate() ?? false) {
//                   _formKey.currentState?.save();
//
//                   String errMsg = attributeManager.checkRequiredAttributes(
//                     billingData?.billingAddress?.billingNewAddress
//                             ?.customAddressAttributes ??
//                         [],
//                   );
//                   if (errMsg.isNotEmpty) {
//                     controller.buildErrorSnackBar(msg: errMsg);
//                   } else {
//                     controller.saveBillingAddress(
//                       newAddress: true,
//                       address: billingData?.billingAddress?.billingNewAddress,
//                       formValue: attributeManager
//                           .getSelectedAttributes('address_attribute'),
//                     );
//                   }
//                 }
//               }
//             },
//           ),
//           const SizedBox(height: 10),
//         ],
//       );
//     } else {
//       temp = Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (shippingAddress?.displayPickupInStore == true &&
//               shippingAddress?.pickupPointsModel?.allowPickupInStore == true)
//             CheckboxListTile(
//               value: controller.storePickup,
//               title: Text(ConstStrings.CHECKOUT_PICKUP_FROM_STORE.translate),
//               onChanged: (bool? isSelected) {
//                 setState(() {
//                   controller.storePickup = isSelected;
//                   if (isSelected ?? false) {
//                     controller.showNewShippingAddress = false;
//                   }
//                 });
//               },
//             ),
//           (controller.storePickup ==true)
//               ? AppDropDownMenuFormFieldWidget<PickupPoint>(
//                   keyName: '',
//                   initialValue: controller.pickupPointAddress?.firstOrNull,
//                   itemsList: controller.pickupPointAddress ?? [],
//                   getItemName: (value) =>
//                       '${value.name ?? ''}, ${value.address ?? ''}, ${value.city ?? ''} ${value.countryName ?? ''}'
//                           .trim(),
//                   onChanged: (value) {
//                     setState(() {
//                       controller.selectedPickupAddress = value;
//                     });
//                   },
//                   onSaved: (newValue) {
//                     /*_bloc.selectedCountry = newValue;
//                       formData.countryId = int.tryParse(newValue.value);*/
//                   },
//                   validator: (value) {
//                     /*if (formData.countyEnabled && (value == null || value.value == '0'))
//                      return _globalService.getString(ConstStrings.COUNTRY_REQUIRED);*/
//                     return null;
//                   },
//                 )
//               : AppDropDownMenuFormFieldWidget<Address>(
//                   keyName: ConstStrings.SHIPPING_ADDRESS_TAB,
//                   initialValue: controller.existingShippingAddress?.firstOrNull,
//                   itemsList: controller.existingShippingAddress ?? [],
//                   getItemName: (value) =>
//                       '${value.firstName ?? ''} ${value.lastName ?? ''}, ${value.email ?? ''}',
//                   onChanged: (value) {
//                     setState(() {
//                       controller.showNewShippingAddress = value?.id == -1;
//                       controller.selectedShippingAddress = value;
//                     });
//                   },
//                   validator: (value) {
//                     /*if (formData.countyEnabled && (value == null || value.value == '0'))
//                       return _globalService.getString(ConstStrings.COUNTRY_REQUIRED);*/
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     /*_bloc.selectedCountry = newValue;
//                     formData.countryId = int.tryParse(newValue.value);*/
//                   },
//                 ),
//           if ((controller.showNewShippingAddress ?? false) &&
//               (shippingAddress!.shippingNewAddress != null))
//             NewAddressForm(
//               formKey: _formKey,
//               bloc: controller,
//               attributeManager: attributeManager,
//               formData: shippingAddress!.shippingNewAddress!,
//               onSubmit: () {},
//             ),
//           const SizedBox(height: 12),
//           ActionButton(
//             text: ConstStrings.CONTINUE.translate.toUpperCase(),
//             onPressed: () {
//               if (!(controller.storePickup ?? false) &&
//                   (controller.selectedShippingAddress?.id ?? -1) ==
//                       -1) {
//                 if (_formKey.currentState?.validate() ?? false) {
//                   _formKey.currentState?.save();
//
//                   String errMsg = attributeManager.checkRequiredAttributes(
//                           shippingAddress?.shippingNewAddress
//                                   ?.customAddressAttributes ??
//                               []) ??
//                       '';
//                   if (errMsg.isNotEmpty) {
//                     controller.buildErrorSnackBar(msg: errMsg);
//                   } else {
//                     controller.saveShippingAddress(
//                       isNewAddress: true,
//                       address: shippingAddress?.shippingNewAddress,
//                       formValue: attributeManager
//                           .getSelectedAttributes('address_attribute'),
//                     );
//                   }
//                 }
//               } else {
//                 controller.saveShippingAddress(
//                   isNewAddress: false,
//                 );
//               }
//             },
//           ),
//           const SizedBox(height: 10),
//         ],
//       );
//     }
//
//     return SingleChildScrollView(
//       padding: SharedStyle.singleChildScrollViewHorizontalPadding,
//       child: Column(
//         children: [
//           ToggleButtons(
//             onPressed: (int index) {
//               setState(() {
//                 for (int buttonIndex = 0;
//                     buttonIndex < isSelected.length;
//                     buttonIndex++) {
//                   if (buttonIndex == index) {
//                     isSelected[buttonIndex] = true;
//                   } else {
//                     isSelected[buttonIndex] = false;
//                   }
//                 }
//                 // set current step
//                 switch (index) {
//                   case 0:
//                     break;
//                   case 1:
//                     break;
//                 }
//               });
//             },
//             isSelected: isSelected,
//             selectedColor: Theme.of(context).colorScheme.primary,
//             renderBorder: false,
//             children: [
//               Text(
//                 ConstStrings.BILLING_ADDRESS_TAB.translate,
//               ),
//               Text(
//                 ConstStrings.SHIPPING_ADDRESS_TAB.translate,
//               ),
//             ],
//           ),
//           temp,
//         ],
//       ),
//     );
//   }
// }
