import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CapitalizeWordsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String capitalize(String word) =>
        word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : '';

    final words = newValue.text.split(' ');
    final capitalizedWords = words.map(capitalize).join(' ');

    return newValue.copyWith(
      text: capitalizedWords,
      selection: newValue.selection,
    );
  }
}

class FullCapitalizeWordsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final capitalizedText = newValue.text.toUpperCase();

    return newValue.copyWith(
      text: capitalizedText,
      selection: updateCursorPosition(capitalizedText),
    );
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.collapsed(offset: text.length);
  }
}

/// Custom formatter for Tanzanian phone numbers with the following rules:
/// - Numbers starting with 255: Must be exactly 12 digits (e.g., 255777777777)
/// - Numbers starting with 0: Must be at least 10 digits (e.g., 0777777777)
/// - Numbers starting with 7 or 6: Must be at least 9 digits, but should be prefixed with 0
class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Allow backspace and deletion
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    String formattedValue = newValue.text;
    // Remove any non-digit characters
    formattedValue = formattedValue.replaceAll(RegExp(r'[^\d]'), '');

    // Check for numbers starting with 255 (country code for Tanzania)
    if (formattedValue.startsWith('255')) {
      // Limit to exactly 12 digits for numbers with country code
      if (formattedValue.length > 12) {
        formattedValue = formattedValue.substring(0, 12);
      }
    }
    // Check for numbers starting with 0 (local format)
    else if (formattedValue.startsWith('0')) {
      // Limit to max 10 digits for numbers starting with 0
      if (formattedValue.length > 10) {
        formattedValue = formattedValue.substring(0, 10);
      }
    }
    // Handle numbers starting with 7 or 6 (needs to be converted to 0 format)
    else if (formattedValue.startsWith('7') || formattedValue.startsWith('6')) {
      // For API compatibility, prepend 0 automatically
      if (formattedValue.length >= 9) {
        // If user entered 9 digits starting with 7 or 6, prepend a 0
        formattedValue = '0$formattedValue';

        // And then limit to 10 digits total
        if (formattedValue.length > 10) {
          formattedValue = formattedValue.substring(0, 10);
        }
      }
    }

    // Create a new TextEditingValue with the formatted text
    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}

/// Extension on TextEditingController to format phone numbers on submit
extension PhoneNumberControllerExtension on TextEditingController {
  /// Format phone number according to the country requirements when form is submitted
  String getFormattedPhoneNumber() {
    String value = text.trim();

    // If empty, return as is
    if (value.isEmpty) {
      return value;
    }

    // If starts with 0, convert to 255 format
    if (value.startsWith('0') && value.length >= 10) {
      // Replace leading 0 with 255
      return '255${value.substring(1)}';
    }

    // If starts with 7 or 6 without a 0, add 255 prefix
    if ((value.startsWith('7') || value.startsWith('6')) && value.length >= 9) {
      return '255$value';
    }

    // If already starts with 255, return as is
    if (value.startsWith('255') && value.length >= 12) {
      return value;
    }

    // Return original value if none of the conditions match
    return value;
  }
}

class DynamicLengthTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // First check if it starts with '0' and allow up to 10 digits
    if (newValue.text.startsWith('0') ||
        newValue.text.startsWith('1') ||
        newValue.text.startsWith('1')) {
      if (newValue.text.length > 10) {
        return TextEditingValue(
          text: newValue.text.substring(0, 10),
          selection: TextSelection.collapsed(offset: 10),
        );
      }
    }
    // Next, check for '6' or '7' and allow up to 9 digits
    else if (newValue.text.startsWith('6') || newValue.text.startsWith('7')) {
      if (newValue.text.length > 9) {
        return TextEditingValue(
          text: newValue.text.substring(0, 9),
          selection: TextSelection.collapsed(offset: 9),
        );
      }
    }
    // Next, check for '255' and allow up to 12 digits
    // else if (newValue.text.startsWith('255')) {
    //   if (newValue.text.length > 9) {
    //     return TextEditingValue(
    //       text: newValue.text.substring(0, 9),
    //       selection: TextSelection.collapsed(offset: 9),
    //     );
    //   }
    // }
    // Default to 9 digits for all other numbers
    else if (newValue.text.length > 9) {
      return TextEditingValue(
        text: newValue.text.substring(0, 9),
        selection: TextSelection.collapsed(offset: 9),
      );
    }
    return newValue;
  }
}
