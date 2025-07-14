import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakani_mobile_app/app/global_widget/action_buttons/action_button.dart';
import 'package:sakani_mobile_app/app/utils/nop_custom_attribute_manager/validation_mixin.dart';
import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/data/models/available_option.dart';
import 'package:sakani_mobile_app/app/data/models/get_billing_address_response.dart';
import 'package:sakani_mobile_app/app/global_widget/all_form_widgets/input_text_field_widget.dart';
import 'package:sakani_mobile_app/app/modules/checkout_page/checkout_controller.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';
import 'package:sakani_mobile_app/app/utils/nop_custom_attribute_manager/custom_attribute_manager.dart';
import '../../../../global_widget/all_form_widgets/drop_down_menu_form_field_widget.dart';
import '../../../../global_widget/app_bar_widgets/app_back_button.dart';
import '../../../../global_widget/app_ui_helper/shared_style.dart';
import '../../../../global_widget/app_ui_helper/ui_helpers.dart';

class NewAddressForm extends StatelessWidget with ValidationMixin {
  final Address formData;
  final GlobalKey<FormBuilderState> formKey;

  final CheckoutController bloc;

  final CustomAttributeManager attributeManager;

  final VoidCallback onSubmit;

  const NewAddressForm({
    super.key,
    required this.formData,
    required this.formKey,
    required this.bloc,
    required this.attributeManager,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        top: MediaQuery.viewPaddingOf(context).top * 1.5,
        // horizontal: 12.w,
        // vertical: 24.h,
      ),
      shape: SharedStyle.bottomSheetShape,
      child: SingleChildScrollView(
        padding: SharedStyle.singleChildScrollViewHorizontalPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UiHelper.verticalSpaceMedium,
            Row(
              children: [
                Text(
                  ConstStrings.ADD_NEW_ADDRESS.translate,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium.withBoldFont,
                ),
                Spacer(),
                AppBackButton(
                  onlyIcon: false,
                  radius: 14.r,
                  padding: EdgeInsets.all(4),
                  backgroundColor: Theme.of(context).primaryColorLight,
                  iconColor: Theme.of(context).disabledColor,
                  iconData: CupertinoIcons.xmark,
                  iconSize: 20.sp,
                ),
              ],
            ).marginSymmetric(
              horizontal: SharedStyle.horizontalScreenPadding,
              // vertical: 12.h,
            ),
            FormBuilder(
              key: formKey,
              child: Column(
                children: <Widget>[
                  //region tfFirstName,
                  InputTextFieldWidget(
                    keyName: ConstStrings.FIRST_NAME,
                    labelText: ConstStrings.FIRST_NAME.translate,
                    hintText: ConstStrings.FIRST_NAME.translate,
                    keyboardType: TextInputType.name,
                    autoFocus: false,
                    isRequired: true,
                    // requiredValidatorText: ConstStrings.FIRST_NAME.translate,
                    onChanged: (value) => formData.firstName = value,
                    onSaved: (value) => formData.firstName = value,
                    initialValue: formData.firstName,
                    textInputAction: TextInputAction.next,
                    // decoration: inputDecor(ConstStrings.FIRST_NAME, true, context),
                  ),
                  //endregion,

                  //region tfLastName,
                  InputTextFieldWidget(
                    keyName: ConstStrings.LAST_NAME,
                    labelText: ConstStrings.LAST_NAME.translate,
                    hintText: ConstStrings.LAST_NAME.translate,
                    keyboardType: TextInputType.name,
                    autoFocus: false,
                    isRequired: true,
                    onChanged: (value) => formData.lastName = value,
                    onSaved: (value) => formData.lastName = value,
                    initialValue: formData.lastName,
                    textInputAction: TextInputAction.next,
                    // decoration: inputDecor(ConstStrings.LAST_NAME, true, context),
                  ),
                  //endregion,

                  //region tfEmail,
                  InputTextFieldWidget(
                    keyName: ConstStrings.EMAIL,
                    labelText: ConstStrings.EMAIL.translate,
                    hintText: ConstStrings.EMAIL.translate,
                    keyboardType: TextInputType.emailAddress,
                    autoFocus: false,
                    isEmail: true,
                    isRequired: true,
                    onChanged: (value) => formData.email = value,
                    onSaved: (value) => formData.email = value,
                    initialValue: formData.email,
                    textInputAction: TextInputAction.next,
                  ),
                  //endregion

                  //region country
                  if (formData.countryEnabled)
                    AppDropDownMenuFormFieldWidget<AvailableOption?>(
                      keyName: ConstStrings.SELECT_COUNTRY,
                      labelText: ConstStrings.SELECT_COUNTRY.translate,
                      hintText: ConstStrings.SELECT_COUNTRY.translate,
                      initialValue: bloc.selectedCountry,
                      itemsList: formData.availableCountries ?? [],
                      getItemName: (value) => value?.text ?? '',
                      onChanged: (value) {
                        if (value != null) {
                          bloc.selectedCountry = value;
                          formData.countryId =
                              int.tryParse(value.value ?? '') ?? 0;
                          if (formData.countryId != null) {
                            int countryId = int.tryParse(value.value ?? '') ?? -1;
                            bloc.fetchStates(countryId);
                          }
                        }
                      },
                      onSaved: (value) {
                        formData.countryId =
                            int.tryParse(value?.value ?? '') ?? 0;
                      },
                      validator: (value) {
                        if ((formData.countryEnabled) &&
                            (value == null || value.serverValue == '0')) {
                          return ConstStrings.COUNTRY_REQUIRED;
                        }
                        return null;
                      },
                    ),
                  //endregion

                  //region States Dropdown
                  if (formData.stateProvinceEnabled)
                    Obx(() {
                      bloc.statesList;
                      return bloc.loadingStates.value
                          ? UiHelper.horizontalSpaceSpinKitProgressIndicator(
                              size: 40)
                          : AppDropDownMenuFormFieldWidget<AvailableOption?>(
                              keyName: ConstStrings.SELECT_STATE,
                              labelText: ConstStrings.SELECT_STATE.translate,
                              hintText: ConstStrings.SELECT_STATE.translate,
                              onChanged: (value) {
                                // bloc.selectedCountry = value;
                                formData.stateProvinceId =
                                    int.tryParse(value?.value ?? '') ?? 0;
                              },
                              onSaved: (newValue) {
                                formData.stateProvinceId =
                                    int.tryParse(newValue?.value ?? '') ?? 0;
                              },
                              // isRequired: true,
                              validator: (value) {
                                if ((formData.stateProvinceEnabled == true) &&
                                    value == null) {
                                  return ConstStrings.STATE_REQUIRED.translate;
                                }
                                return null;
                              },
                              initialValue: bloc.statesList.firstWhereOrNull(
                                    (element) => element.selected ?? false,
                                  ) ??
                                  bloc.statesList.firstOrNull,
                              itemsList: bloc.statesList,
                              getItemName: (AvailableOption? value) =>
                                  kDebugMode
                                      ? '${value?.value} - ${value?.text}'
                                      : value?.text ?? '',
                            );
                    }),
                  //endregion

                  //region tfPhone,
                  if (formData.phoneEnabled)
                    InputTextFieldWidget(
                      keyName: ConstStrings.PHONE,
                      labelText: ConstStrings.PHONE.translate,
                      hintText: ConstStrings.PHONE.translate,
                      keyboardType: TextInputType.phone,
                      autoFocus: false,
                      isRequired:
                          formData.phoneEnabled && formData.phoneRequired,
                      // validator: (value) {
                      //   if (formData.phoneEnabled &&
                      //       formData.phoneRequired &&
                      //       (value == null || value.isEmpty)) {
                      //     return ConstStrings.PHONE.translate;
                      //   }
                      //   return null;
                      // },
                      onChanged: (value) => formData.phoneNumber = value,
                      onSaved: (value) => formData.phoneNumber = value,
                      initialValue: formData.phoneNumber,
                      textInputAction: TextInputAction.next,
                      // decoration: inputDecor(ConstStrings.PHONE, formData.phoneEnabled && formData.phoneRequired, context),
                    ),
                  //endregion

                  //region tfFax,
                  if (formData.faxEnabled)
                    InputTextFieldWidget(
                      keyName: ConstStrings.FAX,
                      labelText: ConstStrings.FAX.translate,
                      hintText: ConstStrings.FAX.translate,
                      keyboardType: TextInputType.phone,
                      autoFocus: false,
                      isRequired: formData.faxEnabled && formData.faxRequired,
                      // validator: (value) {
                      //   if (formData.faxEnabled &&
                      //       formData.faxRequired &&
                      //       (value == null || value.isEmpty)) {
                      //     return ConstStrings.FAX.translate;
                      //   }
                      //   return null;
                      // },
                      onChanged: (value) => formData.faxNumber = value,
                      onSaved: (value) => formData.faxNumber = value,
                      initialValue: formData.faxNumber,
                      textInputAction: TextInputAction.next,
                      // decoration: inputDecor(ConstStrings.FAX, formData.faxEnabled && formData.faxRequired, context),
                    ),
                  //endregion
                  //region tfStreetAddress,
                  if (formData.streetAddressEnabled)
                    InputTextFieldWidget(
                      keyName: ConstStrings.STREET_ADDRESS,
                      labelText: ConstStrings.STREET_ADDRESS.translate,
                      hintText: ConstStrings.STREET_ADDRESS.translate,
                      keyboardType: TextInputType.name,
                      autoFocus: false,
                      isRequired: formData.streetAddressEnabled &&
                          formData.streetAddressRequired,
                      // validator: (value) {
                      //   if (formData.streetAddressEnabled &&
                      //       formData.streetAddressRequired &&
                      //       (value == null || value.isEmpty)) {
                      //     return ConstStrings.STREET_ADDRESS.translate;
                      //   }
                      //   return null;
                      // },
                      onChanged: (value) => formData.address1 = value,
                      onSaved: (value) => formData.address1 = value,
                      initialValue: formData.address1,
                      textInputAction: TextInputAction.next,
                      // decoration: inputDecor(ConstStrings.STREET_ADDRESS, formData.streetAddressEnabled && formData.streetAddressRequired,context),
                    ),
                  //endregion
                  //region tfStreetAddress2,
                  if (formData.streetAddress2Enabled)
                    InputTextFieldWidget(
                      keyName: ConstStrings.STREET_ADDRESS_2,
                      labelText: ConstStrings.STREET_ADDRESS_2.translate,
                      hintText: ConstStrings.STREET_ADDRESS_2.translate,
                      keyboardType: TextInputType.name,
                      autoFocus: false,
                      isRequired: formData.streetAddress2Enabled &&
                          formData.streetAddress2Required,
                      // validator: (value) {
                      //   if (formData.streetAddress2Enabled &&
                      //       formData.streetAddress2Required &&
                      //       (value == null || value.isEmpty)) {
                      //     return ConstStrings.STREET_ADDRESS_2.translate;
                      //   }
                      //   return null;
                      // },
                      onChanged: (value) => formData.address2 = value,
                      onSaved: (value) => formData.address2 = value,
                      initialValue: formData.address2,
                      textInputAction: TextInputAction.next,
                      // decoration: inputDecor(ConstStrings.STREET_ADDRESS_2,formData.streetAddress2Enabled && formData.streetAddress2Required,context),
                    ),
                  //endregion
                  //region tfZip,
                  if (formData.zipPostalCodeEnabled)
                    InputTextFieldWidget(
                      keyName: ConstStrings.ZIP_CODE,
                      labelText: ConstStrings.ZIP_CODE.translate,
                      hintText: ConstStrings.ZIP_CODE.translate,
                      keyboardType: TextInputType.text,
                      autoFocus: false,
                      isRequired: formData.zipPostalCodeEnabled &&
                          formData.zipPostalCodeRequired,
                      // validator: (value) {
                      //   if (formData.zipPostalCodeEnabled &&
                      //       formData.zipPostalCodeRequired &&
                      //       (value == null || value.isEmpty)) {
                      //     return ConstStrings.ZIP_CODE.translate;
                      //   }
                      //   return null;
                      // },
                      onChanged: (value) => formData.zipPostalCode = value,
                      onSaved: (value) => formData.zipPostalCode = value,
                      initialValue: formData.zipPostalCode,
                      textInputAction: TextInputAction.next,
                      // decoration: inputDecor(ConstStrings.ZIP_CODE,formData.zipPostalCodeEnabled &&formData.zipPostalCodeRequired,context),
                    ),
                  //endregion

                  //region tfCounty,
                  if (formData.countyEnabled)
                    InputTextFieldWidget(
                      keyName: ConstStrings.ADDRESS_COUNTY,
                      labelText: ConstStrings.ADDRESS_COUNTY.translate,
                      keyboardType: TextInputType.name,
                      autoFocus: false,
                      isRequired:
                          formData.countyEnabled && formData.countyRequired,
                      // validator: (value) {
                      //   if (formData.countyEnabled &&
                      //       formData.countyRequired &&
                      //       (value == null || value.isEmpty)) {
                      //     return ConstStrings.ADDRESS_COUNTY.translate;
                      //   }
                      //   return null;
                      // },
                      onChanged: (value) => formData.county = value,
                      onSaved: (value) => formData.county = value,
                      initialValue: formData.county,
                      textInputAction: TextInputAction.next,
                      // decoration: inputDecor(ConstStrings.ADDRESS_COUNTY,formData.countyEnabled && formData.countyRequired, context),
                    ),
                  //endregion

                  //region tfCity,
                  if (formData.cityEnabled)
                    InputTextFieldWidget(
                      keyName: ConstStrings.CITY,
                      labelText: ConstStrings.CITY.translate,
                      hintText: ConstStrings.CITY.translate,
                      keyboardType: TextInputType.name,
                      autoFocus: false,
                      isRequired: formData.cityEnabled && formData.cityRequired,
                      // validator: (value) {
                      //   if (formData.cityEnabled &&
                      //       formData.cityRequired &&
                      //       (value == null || value.isEmpty)) {
                      //     return ConstStrings.CITY.translate;
                      //   }
                      //   return null;
                      // },
                      onChanged: (value) => formData.city = value,
                      onSaved: (value) => formData.city = value,
                      initialValue: formData.city,
                      textInputAction: TextInputAction.next,
                      // decoration: inputDecor(ConstStrings.CITY,formData.cityEnabled && formData.cityRequired, context),
                    ),
                  //endregion

                  //region tfCompany,
                  if (formData.companyEnabled)
                    InputTextFieldWidget(
                      keyName: ConstStrings.COMPANY,
                      labelText: ConstStrings.COMPANY.translate,
                      hintText: ConstStrings.COMPANY.translate,
                      keyboardType: TextInputType.name,
                      autoFocus: false,
                      isRequired:
                          formData.companyEnabled && formData.companyRequired,
                      // validator: (value) {
                      //   if (formData.companyEnabled &&
                      //       formData.companyRequired &&
                      //       (value == null || value.isEmpty)) {
                      //     return ConstStrings.COMPANY.translate;
                      //   }
                      //   return null;
                      // },
                      onChanged: (value) => formData.company = value,
                      onSaved: (value) => formData.company = value,
                      initialValue: formData.company,
                      textInputAction: TextInputAction.next,
                      // decoration: inputDecor(ConstStrings.COMPANY,formData.companyEnabled && formData.companyRequired, context),
                    ),
                  //endregion

                  attributeManager.populateCustomAttributes(
                    formData.customAddressAttributes,
                    context,
                  ),

                  // const SizedBox(height: 12),
                  ActionButton(
                    text: ConstStrings.CONTINUE.translate.toUpperCase(),
                    onPressed: onSubmit,
                  ),
                  // const SizedBox(height: 10),
                ].withSpaceBetween(
                  height: 16.0,
                  includeBeforFirst: true,
                  includeAfterLast: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
