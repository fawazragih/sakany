import 'package:flutter/services.dart';

class ArToEnNumbersTextInputFormatter extends TextInputFormatter {
  final bool acceptOnlyDigits;

  ArToEnNumbersTextInputFormatter({this.acceptOnlyDigits = false});

  // Map non-English digits to English digits
  static const Map<String, String> _nonEnglishToEnglishDigits = {
    '٠': '0', // Arabic
    '١': '1',
    '٢': '2',
    '٣': '3',
    '٤': '4',
    '٥': '5',
    '٦': '6',
    '٧': '7',
    '٨': '8',
    '٩': '9',
    '۰': '0', // Persian
    '۱': '1',
    '۲': '2',
    '۳': '3',
    '۴': '4',
    '۵': '5',
    '۶': '6',
    '۷': '7',
    '۸': '8',
    '۹': '9',
  };

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // Replace non-English digits with English equivalents
    _nonEnglishToEnglishDigits.forEach((nonEnglish, english) {
      newText = newText.replaceAll(nonEnglish, english);
    });

    if (acceptOnlyDigits) {
      // Remove any non-digit characters
      newText = newText.replaceAll(RegExp(r'[^0-9]'), '');
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
