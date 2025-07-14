import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/data/models/available_option.dart';
import 'package:sakani/app/data/models/get_billing_address_response.dart';
import 'package:sakani/app/global_widget/action_buttons/action_button.dart';
import 'package:sakani/app/global_widget/all_form_widgets/input_text_field_widget.dart';
import 'package:sakani/app/global_widget/all_form_widgets/location_picker_from_widget/widgets/location_picker_form_field_widget.dart';
import 'package:sakani/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani/app/global_widget/screen_status_widgets.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';
import 'package:sakani/app/utils/nop_custom_attribute_manager/validation_mixin.dart';
import '../../../global_widget/all_form_widgets/drop_down_menu_form_field_widget.dart';
import '../../../global_widget/app_bar_widgets/custom_app_bar.dart';
import 'add_or_edit_address_controller.dart';

class AddOrEditAddressPage extends GetView<AddOrEditAddressController> {
  static const String routeName = '/app/add-or-edit-address';

  const AddOrEditAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddOrEditAddressController>(builder: (controller) {
      return Scaffold(
        appBar: CustomAppBar(
          title: ConstStrings.ACCOUNT_CUSTOMER_ADDRESS.translate,
        ),
        body: ScreenStatusWidgets(
          controller: controller,
          isEmpty: controller.address == null,
          onRetry: controller.initData,
          dataWidget: SingleChildScrollView(
            padding: SharedStyle.singleChildScrollViewHorizontalPadding,
            child: AddressForm(
              controller: controller,
            ),
          ),
        ),
        bottomNavigationBar: controller.busy || controller.showRetryButton
            ? null
            : Padding(
              padding:SharedStyle.bottomNavigationPadding,
              child: ActionButton(
                  text: ConstStrings.SAVE_BUTTON.translate.capitalize,
                  onPressed: controller.saveAddress,
                ),
            ),
      );
    });
  }
}

class AddressForm extends StatelessWidget with ValidationMixin {
  final AddOrEditAddressController controller;

  AddressForm({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final address = controller.address ?? Address();
    return Form(
      key: controller.formKey,
      child: Column(
        children: <Widget>[
          InputTextFieldWidget(
            keyName: ConstStrings.FIRST_NAME,
            labelText: ConstStrings.FIRST_NAME.translate,
            hintText: ConstStrings.FIRST_NAME.translate,
            keyboardType: TextInputType.name,
            autoFocus: false,
            onChanged: (value) => address.firstName = value,
            onSaved: (value) => address.firstName = value,
            initialValue: address.firstName,
            textInputAction: TextInputAction.next,
          ),
          InputTextFieldWidget(
            keyName: ConstStrings.LAST_NAME,
            labelText: ConstStrings.LAST_NAME.translate,
            hintText: ConstStrings.LAST_NAME.translate,
            keyboardType: TextInputType.name,
            autoFocus: false,
            onChanged: (value) => address.lastName = value,
            onSaved: (value) => address.lastName = value,
            initialValue: address.lastName,
            textInputAction: TextInputAction.next,
          ),
          InputTextFieldWidget(
            keyName: ConstStrings.EMAIL,
            labelText: ConstStrings.EMAIL.translate,
            hintText: ConstStrings.EMAIL.translate,
            isEmail: true,
            keyboardType: TextInputType.emailAddress,
            autoFocus: false,
            onChanged: (value) => address.email = value,
            onSaved: (value) => address.email = value,
            initialValue: address.email,
            textInputAction: TextInputAction.next,
          ),
          if (address.countryEnabled)
            AppDropDownMenuFormFieldWidget<AvailableOption>(
              keyName: ConstStrings.COUNTRY,
              labelText: ConstStrings.COUNTRY.translate,
              hintText: ConstStrings.COUNTRY.translate,
              initialValue: address.availableCountries?.firstWhereOrNull(
                    (e) => e.selected == true,
                  ) ??
                  address.availableCountries?.firstOrNull,
              itemsList: address.availableCountries ?? [],
              getItemName: (v) => v.text ?? '',
              onChanged: (value) {
                address.countryId = int.tryParse(value?.value ?? '');
                if (address.countryId != null) {
                  controller.fetchStates(address.countryId!);
                }
              },
              onSaved: (value) {
                address.countryId = int.tryParse(value?.value ?? '') ?? 0;
              },
              isRequired: address.countryEnabled,
            ),
          if (address.stateProvinceEnabled)
            Obx(() {
              return controller.loadingStates.value
                  ? UiHelper.horizontalSpaceSpinKitProgressIndicator(size: 40)
                  : AppDropDownMenuFormFieldWidget<AvailableOption>(
                      keyName: ConstStrings.STATE_PROVINCE,
                      labelText: ConstStrings.STATE_PROVINCE.translate,
                      hintText: ConstStrings.STATE_PROVINCE.translate,
                      getItemName: (v) => v.text ?? '',
                      initialValue: address.availableStates?.firstWhereOrNull(
                            (element) => element.selected ?? false,
                          ) ??
                          address.availableStates?.firstOrNull,
                      itemsList: address.availableStates ?? [],
                      onChanged: (value) {
                        // if (value != null) onDropdownItemSelected(value, false);
                        address.stateProvinceId =
                            int.tryParse(value?.value ?? '') ?? 0;
                      },
                      onSaved: (value) {
                        address.stateProvinceId =
                            int.tryParse(value?.value ?? '') ?? 0;
                      },
                      isRequired: address.stateProvinceEnabled,
                    );
            }),
          if (address.locationEnabled)
            LocationPickerFormFieldWidget(
              onChanged: (value) => address.location = value,
              initialValue: address.location,
              label: ConstStrings.LOCATION.translate,
              isRequired: address.locationEnabled && address.locationRequired,
              onSaved: (value) => address.location = value,
            ),
          if (address.phoneEnabled)
            InputTextFieldWidget(
              keyName: ConstStrings.PHONE,
              labelText: ConstStrings.PHONE.translate,
              hintText: ConstStrings.PHONE.translate,
              keyboardType: TextInputType.phone,
              isRequired: address.phoneEnabled && address.phoneRequired,
              onChanged: (value) => address.phoneNumber = value,
              onSaved: (value) => address.phoneNumber = value,
              initialValue: address.phoneNumber,
              textInputAction: TextInputAction.next,
            ),
          if (address.faxEnabled)
            InputTextFieldWidget(
              keyName: ConstStrings.FAX,
              labelText: ConstStrings.FAX.translate,
              hintText: ConstStrings.FAX.translate,
              keyboardType: TextInputType.phone,
              isRequired: address.faxEnabled && address.faxRequired,
              onChanged: (value) => address.faxNumber = value,
              onSaved: (value) => address.faxNumber = value,
              initialValue: address.faxNumber,
              textInputAction: TextInputAction.next,
            ),
          if (address.streetAddressEnabled)
            InputTextFieldWidget(
              keyName: ConstStrings.STREET_ADDRESS,
              labelText: ConstStrings.STREET_ADDRESS.translate,
              hintText: ConstStrings.STREET_ADDRESS.translate,
              keyboardType: TextInputType.name,
              isRequired:
                  address.streetAddressEnabled && address.streetAddressRequired,
              onChanged: (value) => address.address1 = value,
              onSaved: (value) => address.address1 = value,
              initialValue: address.address1,
              textInputAction: TextInputAction.next,
            ),
          if (address.streetAddress2Enabled)
            InputTextFieldWidget(
              keyName: ConstStrings.STREET_ADDRESS_2,
              labelText: ConstStrings.STREET_ADDRESS_2.translate,
              hintText: ConstStrings.STREET_ADDRESS_2.translate,
              keyboardType: TextInputType.name,
              isRequired: address.streetAddress2Enabled &&
                  address.streetAddress2Required,
              onChanged: (value) => address.address2 = value,
              onSaved: (value) => address.address2 = value,
              initialValue: address.address2,
              textInputAction: TextInputAction.next,
            ),
          if (address.zipPostalCodeEnabled)
            InputTextFieldWidget(
              keyName: ConstStrings.ZIP_CODE,
              labelText: ConstStrings.ZIP_CODE.translate,
              hintText: ConstStrings.ZIP_CODE.translate,
              keyboardType: TextInputType.text,
              isRequired:
                  address.zipPostalCodeEnabled && address.zipPostalCodeRequired,
              onChanged: (value) => address.zipPostalCode = value,
              onSaved: (value) => address.zipPostalCode = value,
              initialValue: address.zipPostalCode,
              textInputAction: TextInputAction.next,
            ),
          if (address.countyEnabled)
            InputTextFieldWidget(
              keyName: ConstStrings.ADDRESS_COUNTY,
              labelText: ConstStrings.ADDRESS_COUNTY.translate,
              hintText: ConstStrings.ADDRESS_COUNTY.translate,
              keyboardType: TextInputType.name,
              isRequired: address.countyEnabled && address.countyRequired,
              onChanged: (value) => address.county = value,
              onSaved: (value) => address.county = value,
              initialValue: address.county,
              textInputAction: TextInputAction.next,
            ),
          if (address.cityEnabled)
            InputTextFieldWidget(
              keyName: ConstStrings.CITY,
              labelText: ConstStrings.CITY.translate,
              hintText: ConstStrings.CITY.translate,
              isRequired: address.cityEnabled && address.cityRequired,
              keyboardType: TextInputType.name,
              onChanged: (value) => address.city = value,
              onSaved: (value) => address.city = value,
              initialValue: address.city,
              textInputAction: TextInputAction.next,
            ),
          if (address.companyEnabled)
            InputTextFieldWidget(
              keyName: ConstStrings.COMPANY,
              labelText: ConstStrings.COMPANY.translate,
              hintText: ConstStrings.COMPANY.translate,
              keyboardType: TextInputType.name,
              isRequired: address.companyEnabled && address.companyRequired,
              onChanged: (value) => address.company = value,
              onSaved: (value) => address.company = value,
              initialValue: address.company,
              textInputAction: TextInputAction.next,
              // decoration: inputDecor(ConstStrings.COMPANY, address.companyEnabled && address.companyRequired, context),
            ),
          controller.attributeManager.populateCustomAttributes(
              address.customAddressAttributes, context),
        ].withSpaceBetween(
          height: 16.0.h,
          includeBeforFirst: true,
          includeAfterLast: true,
        ),
      ),
    );
  }
}
