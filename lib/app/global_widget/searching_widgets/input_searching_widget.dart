import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../all_form_widgets/input_text_field_widget.dart';

class InputSearchingWidget extends StatefulWidget {
  const InputSearchingWidget({
    super.key,
    required this.onSearchChange,
    required this.searchText,
    required this.color,
    this.onClearSearch,
    this.elevation,
    // this.borderColor,
  });

  final AsyncValueSetter<String?>? onSearchChange;
  final VoidCallback? onClearSearch;
  final String? searchText;
  final Color? color;
  // final Color? borderColor;
  final double? elevation;

  @override
  State<InputSearchingWidget> createState() => _InputSearchingWidgetState();
}

class _InputSearchingWidgetState extends State<InputSearchingWidget> {
  final TextEditingController _controller = TextEditingController();

  bool _searching = false;

  changeSearchingState(bool value) {
    if (value != _searching) {
      setState(() {
        _searching = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputTextFieldWidget(
          keyName: 'keyName',
          controller: _controller,
          autoFocus: false,
          // inputBorder: AppInputDecorationStyle.enabledBorder,
          // borderSide: AppInputDecorationStyle.borderSide,
          // inputBorder: OutlineInputBorder(
          //   borderSide: BorderSide(
          //     color: Colors.white,
          //     width: 0.5,
          //   ),
          //   borderRadius: BorderRadius.circular(17),
          // ),
          onChanged: (String? query) async {
            changeSearchingState(true);
            await widget.onSearchChange?.call(query);
            changeSearchingState(false);
          },
          hintText: widget.searchText ?? AppStrings.search.tr.capitalize!,
          fillColor: widget.color ?? Get.theme.inputDecorationTheme.fillColor,
          maxLines: 1,
          minIconConstraint: 55.r,
          contentPadding: EdgeInsets.all(14.r),
          prefixIcon: Icon(
            Icons.search,
            size: 16,
            color: Get.theme.disabledColor,
          ),
          suffixIcon:
              widget.onClearSearch != null && _controller.text.isNotEmpty
                  ? InkWell(
                      onTap: () {
                        _controller.clear();
                        widget.onClearSearch?.call();
                        changeSearchingState(false);
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Get.theme.disabledColor,
                      ),
                    )
                  : null,
        ),
        if (_searching)
          LinearProgressIndicator(
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              Get.theme.colorScheme.primary,
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
