import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sakani/app/base_controllers_and_listeners/helpers_methods.dart';
import 'package:sakani/app/global_widget/horizontal_list_builder.dart';
import '../app_ui_helper/ui_helpers.dart';

class DynamicChoiceChipsFormWidget<T> extends StatelessWidget {
  final T? initialValue;
  final List<T> choices;
  final String keyName;
  final String? labelText;
  final bool isRequired;
  final bool labelAndChoicesInRow;
  final Color? selectedBgColor;
  final bool inHorizontalListBuilder;
  final WrapAlignment? wrapAlignment;
  final ValueChanged<T?>? onChange;
  final ValueChanged<T?>? onSaved;
  final ValueSetterAndGetter<T, String> getName;

  const DynamicChoiceChipsFormWidget({
    super.key,
    required this.keyName,
    required this.choices,
    this.labelText,
    this.isRequired = true,
    this.initialValue,
    this.selectedBgColor,
    this.onChange,
    this.onSaved,
    this.inHorizontalListBuilder = false,
    this.labelAndChoicesInRow = false,
    this.wrapAlignment,
    required this.getName,
  });

  @override
  Widget build(BuildContext context) {
    return labelAndChoicesInRow
        ? Row(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (labelText != null)
                Text(
                  '$labelText :',
                  style: Theme.of(context).textTheme.bodySmall?.withBoldFont,
                ).paddingDirection(end: 8.0.w, start: 4.0.w),
              Expanded(
                child: FormBuilderField<T>(
                  name: keyName,
                  validator: FormBuilderValidators.compose([
                    if (isRequired) FormBuilderValidators.required(),
                  ]),
                  initialValue: initialValue,
                  onChanged: onChange,
                  onSaved: onSaved,
                  builder: (FormFieldState<T> field) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          errorText: field.errorText,
                          border: InputBorder.none,
                          isDense: true,
                          enabledBorder: InputBorder.none
                          // labelStyle: AppInputDecorationStyle.labelStyle,
                          // hintStyle: AppInputDecorationStyle.hintStyle,
                          // fillColor: Get.theme.inputDecorationTheme.fillColor,
                          ),
                      child: inHorizontalListBuilder
                          ? HorizontalListBuilder(
                              itemCount: choices.length,
                              items: choices,
                              widget: (item) {
                                bool isIn = (field.value ?? false) == item;
                                String name = getName.call(item);
                                return MyChoiceChip<T>(
                                  selectedBgColor: selectedBgColor,
                                  name: name,
                                  isSelected: isIn,
                                  item: item,
                                  onSelect: field.didChange,
                                ).marginSymmetric(
                                  horizontal: 4.0,
                                );
                              },
                            )
                          : Wrap(
                              direction: Axis.horizontal,
                              runSpacing: 8.w,
                              spacing: 8.w,
                              // alignment: wrapAlignment ?? WrapAlignment.start,
                              children: choices
                                  .map(
                                    (item) {
                                      bool isIn =
                                          (field.value ?? false) == item;
                                      String name = getName.call(item);
                                      return MyChoiceChip<T>(
                                        selectedBgColor: selectedBgColor,
                                        name: name,
                                        isSelected: isIn,
                                        item: item,
                                        onSelect: field.didChange,
                                      );
                                    },
                                  )
                                  .toList()
                                  .cast<Widget>(),
                            ),
                    );
                  },
                ),
              ),
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (labelText != null)
               Text(
                  labelText!,
                  style: Theme.of(context).textTheme.bodySmall?.withBoldFont,
                ).marginOnly(bottom: 8.0.h),
              FormBuilderField<T>(
                name: keyName,
                validator: FormBuilderValidators.compose([
                  if (isRequired) FormBuilderValidators.required(),
                ]),
                initialValue: initialValue,
                onChanged: onChange,
                onSaved: onSaved,
                builder: (FormFieldState<T> field) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        errorText: field.errorText,
                        border: InputBorder.none,
                        isDense: true,
                        enabledBorder: InputBorder.none
                        // labelStyle: AppInputDecorationStyle.labelStyle,
                        // hintStyle: AppInputDecorationStyle.hintStyle,
                        // fillColor: Get.theme.inputDecorationTheme.fillColor,
                        ),
                    child: inHorizontalListBuilder
                        ? HorizontalListBuilder(
                            itemCount: choices.length,
                            items: choices,
                            widget: (item) {
                              bool isIn = (field.value ?? false) == item;
                              String name = getName.call(item);
                              return MyChoiceChip<T>(
                                selectedBgColor: selectedBgColor,
                                name: name,
                                isSelected: isIn,
                                item: item,
                                onSelect: field.didChange,
                              ).marginSymmetric(
                                horizontal: 4.0,
                              );
                            },
                          )
                        : Wrap(
                            direction: Axis.horizontal,
                            runSpacing: 8.w,
                            spacing: 8.w,
                            // alignment: wrapAlignment ?? WrapAlignment.start,
                            children: choices
                                .map(
                                  (item) {
                                    bool isIn = (field.value ?? false) == item;
                                    String name = getName.call(item);
                                    return MyChoiceChip<T>(
                                      selectedBgColor: selectedBgColor,
                                      name: name,
                                      isSelected: isIn,
                                      item: item,
                                      onSelect: field.didChange,
                                    );
                                  },
                                )
                                .toList()
                                .cast<Widget>(),
                          ),
                  );
                },
              ),
            ],
          );
  }
}

class MyChoiceChip<T> extends StatelessWidget {
  final T item;
  final String name;
  final bool isSelected;
  final Color? selectedBgColor;
  final ValueChanged<T> onSelect;

  const MyChoiceChip({
    super.key,
    required this.isSelected,
    required this.item,
    this.selectedBgColor,
    required this.onSelect,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: !isSelected
              ? Theme.of(context).primaryColorLight
              : Theme.of(context).colorScheme.primary,
          width: 1.0,
        ),
      ),
      color: isSelected
          ? selectedBgColor ?? Theme.of(context).cardColor
          : Theme.of(context).cardColor,
      child: InkWell(
        onTap: () {
          onSelect.call(item);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0.w,
            vertical: 8.0.h,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: isSelected
                    ? Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).primaryColorDark,
                        )
                    : Theme.of(context).textTheme.bodySmall?.copyWith(
                        // color: Theme.of(context).primaryColorDark,
                        ),
              ),
              UiHelper.horizontalSpaceSmall,
              !isSelected
                  ? Icon(
                      Icons.circle_outlined,
                      color: Theme.of(context).dividerColor,
                      size: 24,
                    )
                  : Icon(
                      Icons.check_circle,
                      color: Colors.green.shade400,
                      size: 24,
                    ),
              // UiHelper.horizontalSpaceSmall,
            ],
          ),
        ),
      ),
    );
  }
}
