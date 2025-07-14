import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:sakani/app/utils/api_env_config/app_logger_config.dart';
import '../../../../core/language_and_localization/app_strings.dart';
import '../../../app_ui_helper/ui_helpers.dart';
import '../constants/google_map_keys.dart';
import '../models/location_address_model.dart';

class LocationPickerFormFieldWidget extends StatelessWidget {
  final bool isRequired;
  final String? label;
  final String? hint;
  final ValueChanged<AddressLocation?>? onChanged;
  final ValueChanged<AddressLocation?>? onSaved;
  final Color? fillColor;

  // final Color labelTextColor;
  final AddressLocation? initialValue;

  // final String labelText;

  const LocationPickerFormFieldWidget({
    super.key,
    // this.onTap,
    this.isRequired = true,
    this.onChanged,
    this.fillColor,
    this.initialValue,
    this.label,
    this.hint,
    required this.onSaved,
    // this.labelTextColor,
  });

  @override
  Widget build(BuildContext context) {
    Key inputWidgetKey = const Key('value');
    updateInputWidgetKey() => inputWidgetKey = UniqueKey();

    return FormField<AddressLocation>(
        onSaved: onSaved,
        // onChanged: onChange,
        initialValue: initialValue,
        validator: (AddressLocation? value) {
          if (value == null && isRequired) {
            return AppStrings.thisFieldIsRequired.tr.capitalizeFirst!;
          }
          if (value!.formattedAddress.isNullOrEmpty) {
            updateInputWidgetKey();
            return AppStrings
                .pleaseAddLabelToTourPickedAddress.tr.capitalizeFirst!;
          }
          return null;
        },
        builder: (FormFieldState<AddressLocation> field) {
          // logger.d(inputWidgetKe.toString());
          getData(PickResult? value) {
            // logger.d(value);
            if (value != null) {
              AddressLocation intermediateResult =
                  AddressLocation.fromPickResult(value);
              updateInputWidgetKey();
              field.didChange(intermediateResult);
              onChanged?.call(intermediateResult);
            }
          }

          return InputDecorator(
            decoration: InputDecoration(
              fillColor: fillColor ?? context.theme.inputDecorationTheme.fillColor,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 2,
              ),
              border: InputBorder.none,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    key: inputWidgetKey,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: AppStrings.pickLocation.tr.capitalizeFirst!),
                    // decoration: inputDecor(
                    //   label ?? 'Location',
                    //   false,
                    //   context,
                    // ),
                    // errorText: field.errorText,
                    onTap: field.value == null
                        ? () => onGoToPickPlace(field, context).then(
                              (value) => getData(value),
                            )
                        : null,
                    initialValue:
                        field.value?.formattedAddress ?? field.value?.name,
                    onSaved: (value) {
                      logger.d('onsave');
                      field.value?.formattedAddress = value;
                    },
                    onChanged: (value) {
                      logger.d('onChange');
                      field.value?.formattedAddress = value;
                    },
                  ),
                ),
                UiHelper.horizontalSpaceTiny,
                Card(
                  elevation: 0,
                  shape: const CircleBorder(),
                  margin: field.hasError
                      ? const EdgeInsets.only(
                          bottom: 20.0,
                        )
                      : EdgeInsets.zero,
                  color: Theme.of(context).colorScheme.primary,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => onGoToPickPlace(field, context).then(
                      (value) => getData(value),
                    ),
                    child: Icon(
                      Icons.location_on_outlined,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ).paddingAll(8.0),
                ),
              ],
            ),
          );
        });
  }

  Future<dynamic> onGoToPickPlace(
    FormFieldState<AddressLocation> field,
    final BuildContext context,
  ) async {
    bool gpsRes = false;
    bool locationPermission = false;
    // locationPermission = await AppPermissionsHandler.locationPermission();
    // if (locationPermission) {
    //   gpsRes = await AppPermissionsHandler.checkGPSService();
    // }
    if (true || locationPermission && gpsRes) {
      kIsWeb;
      return await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlacePicker(
            apiKey: GoogleMapApiKeys.getKey,
            desiredLocationAccuracy: LocationAccuracy.bestForNavigation,
            onPlacePicked: (PickResult pickedResult) {
              Navigator.pop(context, pickedResult);
            },
            selectedPlaceWidgetBuilder: (
              BuildContext context,
              PickResult? gmPickedResult,
              SearchingState state,
              bool isSearchBarFocused,
            ) {
              logger.d(
                'lat ${gmPickedResult?.geometry?.location.lat}, lang ${gmPickedResult?.geometry?.location.lng}}',
              );
              return FloatingCard(
                bottomPosition: 16.0,
                leftPosition: 16.0,
                rightPosition: 16.0,
                elevation: 0,
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      gmPickedResult?.formattedAddress ?? '',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ).paddingSymmetric(
                      vertical: 12.0,
                    ),
                    UiHelper.verticalSpaceTiny,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary),
                      child:
                          Text(AppStrings.selectLocation.tr.capitalizeFirst!),
                      onPressed: () => Navigator.pop(context, gmPickedResult),
                    ),
                  ],
                ).paddingSymmetric(
                  horizontal: 12.0,
                  vertical: 12.0,
                ),
              );
            },
            initialPosition: initialValue?.latLng ??
                const LatLng(
                  24.466667,
                  54.366669,
                ),
            useCurrentLocation: initialValue == null,
            selectInitialPosition: true,
            enableMapTypeButton: true,
            enableMyLocationButton: true,
          ),
        ),
      );
    } else {
      logger.d(
          'you cant move to choose location please grant location permission enable it first');
    }
  }
}
