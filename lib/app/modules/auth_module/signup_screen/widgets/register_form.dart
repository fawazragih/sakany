import 'package:animate_do/animate_do.dart';
import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/core/language_and_localization/app_strings.dart';
import 'package:sakani/app/data/models/available_option.dart';
import 'package:sakani/app/data/models/register_form_response.dart';
import 'package:sakani/app/global_widget/action_buttons/action_button.dart';
import 'package:sakani/app/global_widget/all_form_widgets/check_box_form_field.dart';
import 'package:sakani/app/global_widget/all_form_widgets/date_picker_widget.dart';
import 'package:sakani/app/global_widget/all_form_widgets/drop_down_menu_form_field_widget.dart';
import 'package:sakani/app/global_widget/all_form_widgets/dynamic_choice_chips_form_widget.dart';
import 'package:sakani/app/global_widget/all_form_widgets/input_text_field_widget.dart';
import 'package:sakani/app/global_widget/all_form_widgets/password_input.dart';
import 'package:sakani/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani/app/modules/auth_module/signup_screen/signup_controller.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';


class RegisterForm extends StatelessWidget {
  const RegisterForm({
    required this.formData,
    required this.controller,
    super.key,
  });

  final RegisterFormData formData;
  final SignupController controller;
  List<Map<String, String>> get genders => [
        {'M': ConstStrings.GENDER_MALE.translate},
        {'F': ConstStrings.GENDER_FEMALE.translate},
      ];

  @override
  Widget build(BuildContext context) {
    return BounceInDown(
      from: 150.h,
      delay: const Duration(milliseconds: 300),
      duration: const Duration(milliseconds: 1200),
      child: FormBuilder(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (controller.completeRegisterWithBasUserData)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: Text(
                  AppStrings.pleaseCompleteRegisterInfo.tr.capitalizeFirst!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),

            SectionHeaderWidget(
              headerText: ConstStrings.REGISTRATION_PERSONAL_DETAILS.translate,
            ),
            if (formData.firstNameEnabled)
              InputTextFieldWidget(
                keyName: ConstStrings.FIRST_NAME,
                keyboardType: TextInputType.name,
                isRequired:
                    formData.firstNameEnabled && formData.firstNameRequired,
                onChanged: (value) => formData.firstName = value,
                onSaved: (value) => formData.firstName = value,
                initialValue: formData.firstName,
                enabled: formData.firstNameEnabled,
                textInputAction: TextInputAction.next,
                hintText: ConstStrings.FIRST_NAME.translate,
                labelText: ConstStrings.FIRST_NAME.translate,
                // decoration: inputDecor(
                //   ConstStrings.FIRST_NAME,
                //   formData.firstNameEnabled && formData.firstNameRequired,
                //   context,
                // ),
              ),
            if (formData.lastNameEnabled)
              InputTextFieldWidget(
                keyName: ConstStrings.LAST_NAME,
                keyboardType: TextInputType.name,
                isRequired:
                    formData.lastNameEnabled && formData.lastNameRequired,
                onChanged: (value) => formData.lastName = value,
                onSaved: (value) => formData.lastName = value,
                initialValue: formData.lastName,
                enabled: formData.lastNameEnabled,
                textInputAction: TextInputAction.next,
                labelText: ConstStrings.LAST_NAME.translate,
                hintText: ConstStrings.LAST_NAME.translate,
                // decoration: inputDecor(
                //   ConstStrings.LAST_NAME,
                //   formData.lastNameEnabled && formData.lastNameRequired,
                //   context,
                // ),
              ),
            if (formData.usernamesEnabled)
              InputTextFieldWidget(
                keyName: ConstStrings.USERNAME,
                isRequired: formData.usernamesEnabled,
                keyboardType: TextInputType.name,
                onChanged: (value) => formData.username = value,
                onSaved: (value) => formData.username = value,
                initialValue: formData.username,
                textInputAction: TextInputAction.next,
                labelText: ConstStrings.USERNAME.translate,
                hintText: ConstStrings.USERNAME.translate,
              ),
            if (formData.dateOfBirthEnabled)
              DateTimePickerFormWidget(
                keyName: ConstStrings.DATE_OF_BIRTH,
                keyboardType: TextInputType.text,
                hintText: ConstStrings.DATE_OF_BIRTH.translate,
                initialValue: formData.userDOB,
                isRequired:
                    formData.dateOfBirthEnabled && formData.dateOfBirthRequired,
                onSaved: (newValue) {
                  if (newValue != null) {
                    formData.dateOfBirthDay = newValue.day;
                    formData.dateOfBirthMonth = newValue.month;
                    formData.dateOfBirthYear = newValue.year;
                  }
                },
                // onTap: () => _selectDate(),
                textInputAction: TextInputAction.next,
                labelText: ConstStrings.DATE_OF_BIRTH,
              ),
            InputTextFieldWidget(
              keyName: ConstStrings.EMAIL,
              keyboardType: TextInputType.emailAddress,
              isEmail: true,
              onChanged: (value) => formData.email = value,
              onSaved: (value) => formData.email = value,
              initialValue: formData.email,
              textInputAction: TextInputAction.next,
              labelText: ConstStrings.EMAIL.translate,
              hintText: ConstStrings.EMAIL.translate,
              // decoration: inputDecor(ConstStrings.EMAIL, true, context),
            ),
            if (formData.enteringEmailTwice)
              InputTextFieldWidget(
                keyName: ConstStrings.CONFIRM_EMAIL,
                keyboardType: TextInputType.emailAddress,
                isRequired: formData.enteringEmailTwice,
                isEmail: true,
                onChanged: (value) => formData.confirmEmail = value,
                onSaved: (value) => formData.confirmEmail = value,
                initialValue: formData.confirmEmail,
                textInputAction: TextInputAction.next,
                labelText: ConstStrings.CONFIRM_EMAIL.translate,
                hintText: ConstStrings.CONFIRM_EMAIL.translate,
              ),
            if (formData.genderEnabled)
              DynamicChoiceChipsFormWidget<Map<String, String>>(
                keyName: ConstStrings.GENDER,
                labelAndChoicesInRow: true,
                isRequired: formData.genderEnabled,
                initialValue: genders.firstWhereOrNull((e) =>
                    e.keys.firstOrNull?.toLowerCase() ==
                    formData.gender?.toLowerCase()),
                labelText: ConstStrings.GENDER.translate,
                choices: genders,
                getName: (Map<String, String> v) => v.values.first,
                onChange: (value) => formData.gender = value?.keys.first,
                onSaved: (value) => formData.gender = value?.keys.first,
              ),

            if (formData.countryEnabled)
              AppDropDownMenuFormFieldWidget<AvailableOption>(
                keyName: ConstStrings.COUNTRY,
                labelText: ConstStrings.COUNTRY.translate,
                hintText: ConstStrings.COUNTRY.translate,
                getItemName: (v) => v.text ?? '',
                onChanged: (value) {
                  // controller.selectedCountry = value;
                  formData.countryId = int.tryParse(value?.value ?? '');
                  if (formData.countryId != null) {
                    controller.fetchStatesByCountryId(formData.countryId!);
                  }
                },
                isRequired: formData.countryEnabled && formData.countryRequired,
                onSaved: (newValue) {
                  // controller.selectedCountry = newValue;
                  formData.countryId = int.tryParse(newValue?.value ?? '');
                },
                initialValue: formData.availableCountries?.firstWhereOrNull(
                      (e) => e.selected == true,
                    ) ??
                    formData.availableCountries?.firstOrNull,
                itemsList: formData.availableCountries ?? [],
              ),
            if (formData.stateProvinceEnabled)
              Obx(() {
                return controller.loadingStates.value
                    ? UiHelper.horizontalSpaceSpinKitProgressIndicator(size: 40)
                    : AppDropDownMenuFormFieldWidget<AvailableOption>(
                        keyName: ConstStrings.STATE_PROVINCE,
                        onChanged: (value) {
                          // controller.selectedState = value;
                          formData.stateProvinceId =
                              int.tryParse(value?.value ?? '');
                        },
                        onSaved: (newValue) {
                          // controller.selectedState = newValue;
                          formData.stateProvinceId =
                              int.tryParse(newValue?.value ?? '');
                        },
                        isRequired: formData.stateProvinceEnabled &&
                            formData.stateProvinceRequired,
                        initialValue: controller
                                .registerFormData?.availableStates
                                ?.firstWhereOrNull(
                              (element) => element.selected ?? false,
                            ) ??
                            formData.availableStates?.firstOrNull,
                        getItemName: (v) => v.text ?? '',
                        itemsList:
                            controller.registerFormData?.availableStates ??
                                List.empty(),
                      );
              }),

            if (formData.allowCustomersToSetTimeZone)
              AppDropDownMenuFormFieldWidget<AvailableOption>(
                keyName: ConstStrings.REGISTER_TIMEZONE,
                onChanged: (value) {
                  // controller.selectedTimeZone = value;
                  formData.timeZoneId = int.tryParse(value?.value ?? '');
                },
                onSaved: (newValue) {
                  // controller.selectedTimeZone = newValue;
                  formData.timeZoneId = int.tryParse(newValue?.value ?? '');
                },
                initialValue: controller.registerFormData?.availableTimeZones
                        ?.firstWhereOrNull(
                      (element) => element.selected ?? false,
                    ) ??
                    formData.availableTimeZones?.firstOrNull,
                getItemName: (v) => v.text ?? '',
                itemsList: formData.availableTimeZones ?? List.empty(),
                isRequired: formData.allowCustomersToSetTimeZone,
              ),
            //region phone num,
            if (formData.phoneEnabled)
              InputTextFieldWidget(
                keyName: ConstStrings.PHONE,
                keyboardType: TextInputType.phone,
                isRequired: formData.phoneEnabled && formData.phoneRequired,
                onChanged: (value) => formData.phone = value,
                onSaved: (value) => formData.phone = value,
                initialValue: formData.phone,
                textInputAction: TextInputAction.next,
                labelText: ConstStrings.PHONE.translate,
                hintText: ConstStrings.PHONE.translate,
              ),
            //endregion
            if (formData.faxEnabled)
              InputTextFieldWidget(
                keyName: ConstStrings.FAX,
                keyboardType: TextInputType.phone,
                isRequired: formData.faxEnabled && formData.faxRequired,
                onChanged: (value) => formData.fax = value,
                onSaved: (value) => formData.fax = value,
                initialValue: formData.fax,
                textInputAction: TextInputAction.next,
                labelText: ConstStrings.FAX.translate,
                hintText: ConstStrings.FAX.translate,
              ),
            if (formData.streetAddressEnabled)
              InputTextFieldWidget(
                keyName: ConstStrings.FAX,
                keyboardType: TextInputType.name,
                isRequired: formData.streetAddressEnabled &&
                    formData.streetAddressRequired,
                onChanged: (value) => formData.streetAddress = value,
                onSaved: (value) => formData.streetAddress = value,
                initialValue: formData.streetAddress,
                textInputAction: TextInputAction.next,
                labelText: ConstStrings.STREET_ADDRESS.translate,
                hintText: ConstStrings.STREET_ADDRESS.translate,
              ),
            if (formData.streetAddress2Enabled)
              InputTextFieldWidget(
                keyName: ConstStrings.STREET_ADDRESS_2,
                keyboardType: TextInputType.name,
                isRequired: formData.streetAddress2Enabled &&
                    formData.streetAddress2Required,
                onSaved: (value) => formData.streetAddress2 = value,
                onChanged: (value) => formData.streetAddress2 = value,
                initialValue: formData.streetAddress2,
                textInputAction: TextInputAction.next,
                labelText: ConstStrings.STREET_ADDRESS_2.translate,
                hintText: ConstStrings.STREET_ADDRESS_2.translate,
              ),
            if (formData.zipPostalCodeEnabled)
              InputTextFieldWidget(
                keyName: ConstStrings.ZIP_CODE,
                keyboardType: TextInputType.text,
                isRequired: formData.zipPostalCodeEnabled &&
                    formData.zipPostalCodeRequired,
                onChanged: (value) => formData.zipPostalCode = value,
                onSaved: (value) => formData.zipPostalCode = value,
                initialValue: formData.zipPostalCode,
                textInputAction: TextInputAction.next,
                labelText: ConstStrings.ZIP_CODE.translate,
                hintText: ConstStrings.ZIP_CODE.translate,
              ),
            if (formData.countyEnabled)
              InputTextFieldWidget(
                keyName: ConstStrings.ADDRESS_COUNTY.translate,
                keyboardType: TextInputType.name,
                onChanged: (value) => formData.county = value,
                onSaved: (value) => formData.county = value,
                initialValue: formData.county,
                isRequired: formData.countyEnabled && formData.countyRequired,
                textInputAction: TextInputAction.next,
                labelText: ConstStrings.ADDRESS_COUNTY.translate,
                hintText: ConstStrings.ADDRESS_COUNTY.translate,
              ),
            if (formData.cityEnabled)
              InputTextFieldWidget(
                keyName: ConstStrings.CITY,
                keyboardType: TextInputType.name,
                onChanged: (value) => formData.city = value,
                onSaved: (value) => formData.city = value,
                initialValue: formData.city,
                isRequired: formData.cityEnabled && formData.cityRequired,
                textInputAction: TextInputAction.next,
                labelText: ConstStrings.CITY.translate,
                hintText: ConstStrings.CITY.translate,
              ),
            if (formData.companyEnabled)
              InputTextFieldWidget(
                keyName: ConstStrings.COMPANY,
                keyboardType: TextInputType.name,
                isRequired: formData.companyEnabled && formData.companyRequired,
                onChanged: (value) => formData.company = value,
                onSaved: (value) => formData.company = value,
                initialValue: formData.company,
                labelText: ConstStrings.COMPANY.translate,
                hintText: ConstStrings.COMPANY.translate,
                textInputAction: TextInputAction.next,
              ),

            //region checkboxAndGdprConsent
            Column(
              children: [
                if (formData.newsletterEnabled ?? false)
                  CheckBoxFormFieldWidget(
                    keyName: ConstStrings.NEWSLETTER,
                    label: ConstStrings.NEWSLETTER.translate,
                    initialValue: formData.newsletter,
                    required:
                        formData.companyEnabled && formData.companyRequired,
                    onChanged: (v) {
                      if (v != null) formData.newsletter = v;
                    },
                    onSaved: (v) {
                      if (v != null) formData.newsletter = v;
                    },
                  ),
                if (formData.acceptPrivacyPolicyEnabled)
                  CheckBoxFormFieldWidget(
                    keyName: ConstStrings.ACCEPT_PRIVACY_POLICY,
                    required: formData.acceptPrivacyPolicyEnabled,
                    label: ConstStrings.ACCEPT_PRIVACY_POLICY.translate,
                    initialValue: formData.acceptPrivacyPolicyPopup,
                    onChanged: (v) {
                      // _bloc.privacyAccepted = !(_bloc.privacyAccepted ?? false);
                      if (v != null) {
                        formData.acceptPrivacyPolicyPopup = v;
                      }
                    },
                    onSaved: (v) {
                      // _bloc.privacyAccepted = !(_bloc.privacyAccepted ?? false);
                      if (v != null) {
                        formData.acceptPrivacyPolicyPopup = v;
                      }
                    },
                  ),
                if (formData.gdprConsents.isNotNullOrEmpty)
                  ...formData.gdprConsents!.map((item) {
                    return CheckBoxFormFieldWidget(
                      keyName: item.message ?? '',
                      label: item.message ?? '',
                      required: item.isRequired == true,
                      initialValue: item.accepted ?? false,
                      onChanged: (v) {
                        item.accepted = v;
                      },
                      onSaved: (v) {
                        item.accepted = v;
                      },
                    );
                  }),
              ],
            ),
            //endregion
            //TODO byMe use ProductCustomAttributes2 Builder after change it to form field widget
            if (formData.customerAttributes.isNotNullOrEmpty)
              controller.attributeManager.populateCustomAttributes(
                formData.customerAttributes,
                context,
              ),
            // SectionHeaderWidget(headerText: 'Custom Attribute'),
            // ProductCustomAttributes2(
            //   attributePrefix: AppConstants.customerAttributePrefix,
            //   attributes: formData.customerAttributes,
            //   onClick: (bool v, List<FormValue> list) {
            //     // updating UI to show selected attribute values
            //     controller.update();
            //   },
            // ),

            //region PasswordInput

            SectionHeaderWidget(
              headerText: ConstStrings.REGISTRATION_PASSWORD.translate,
            ),
            PasswordInput(
              keyName: AppStrings.password,
              hintText: ConstStrings.ENTER_PASSWORD.translate,
              initialValue: formData.password,
              requiredMinLength: 6,
              confirmKeyName: AppStrings.passwordConfirm,
              confirmHintText: ConstStrings.CONFIRM_PASSWORD.translate,
              confirmInitialValue: formData.confirmPassword,
              textInputAction: TextInputAction.next,
              onSaved: (value) => formData.password = value,
              onConfirmSaved: (value) => formData.confirmPassword = value,
              isSignUp: true,
            ),
            //endregion
            ActionButton(
              text: ConstStrings.REGISTER_BUTTON.translate.toUpperCase(),
              onPressed: () =>
                  controller.onSubmit(controller.registerFormData!),
            ),
          ].withSpaceBetween(
            height: 16,
            includeBeforFirst: true,
            includeAfterLast: true,
          ),
        ),
      ),
    );
  }
}

class SectionHeaderWidget extends StatelessWidget {
  const SectionHeaderWidget({
    required this.headerText,
    super.key,
  });

  final String headerText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        headerText,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }
}
