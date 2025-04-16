import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otappfluttertemplate/utils/constants/regex.dart';

/// Comprehensive utility class for handling Tanzania phone numbers
///
/// provides utility methods for handling Tanzania phone numbers. It normalizes
/// phone numbers to a standard format, formats them for display, provides visual
/// hints as the user types, and validates Tanzania phone numbers.
class TzPhoneUtils {
  static const String _countryCode = '255';

  /// Normalizes a phone number to standard Tanzania format (255xxxxxxxxx)
  static String normalizePhoneNumber(String phone) {
    // Remove any non-digit characters
    String digits = phone.replaceAll(digitsOnlyRegex, '');

    // If empty, return as is
    if (digits.isEmpty) return '';

    // Handle the case when user has entered only "255" (country code)
    if (digits == _countryCode) return _countryCode;

    // If it starts with a 0, replace with 255
    if (digits.startsWith('0')) {
      return _countryCode + digits.substring(1);
    }

    // If it already starts with 255, check for issues
    if (digits.startsWith(_countryCode)) {
      // Get subscriber part (after 255)
      String subscriberPart = digits.substring(3);

      // If subscriber part is empty, just return the country code
      if (subscriberPart.isEmpty) return '255';

      // Fix double country code (255255...)
      if (subscriberPart.startsWith('255')) {
        subscriberPart = subscriberPart.substring(3);
      }

      // Fix country code followed by 0 (2550...)
      if (subscriberPart.startsWith('0')) {
        subscriberPart = subscriberPart.substring(1);
      }

      // Ensure subscriber part is the right length (9 digits)
      if (subscriberPart.length > 9) {
        subscriberPart = subscriberPart.substring(0, 9);
      }

      return '255$subscriberPart';
    }

    // If number starts with 6 or 7 (Tanzania mobile prefixes)
    if (digits.startsWith(digitsStartsWithSixOrSeven)) {
      // For incomplete or complete subscriber numbers, just return with country code
      // Don't pad with zeros for display purposes
      if (digits.length <= 9) {
        return '255$digits';
      }

      // If too long, truncate to 9 digits
      return _countryCode + digits.substring(0, 9);
    }

    /// Handle partial inputs, incomplete or odd partial inputs(like "25")
    ///
    /// Just return what they've typed so far - they're still typing
    if (digits.length <= 3) return digits;

    /// For longer inputs that still don't start with expected patterns
    ///
    /// For more complete numbers that could be subscriber parts
    if (digits.length >= 4) return _countryCode + digits;

    // Fallback (should not reach here)
    return digits;
  }

  /// Format for display (e.g., +255 742 123 456)
  static String formatForDisplay(String phone) {
    String normalized = normalizePhoneNumber(phone);

    // Just country code or very short number
    if (normalized.length <= 3) {
      return normalized.startsWith(_countryCode)
          ? '+$_countryCode'
          : normalized;
    }

    // Handle properly normalized numbers (255xxxxxxxxx)
    if (normalized.startsWith(_countryCode)) {
      String subscriberPart = normalized.substring(3);

      // Format based on available digits
      if (subscriberPart.length <= 3) {
        return '+$_countryCode $subscriberPart';
      } else if (subscriberPart.length <= 6) {
        return '+$_countryCode ${subscriberPart.substring(0, 3)} ${subscriberPart.substring(3)}';
      } else {
        String remaining =
            subscriberPart.length > 6 ? subscriberPart.substring(6) : '';
        return '+$_countryCode ${subscriberPart.substring(0, 3)} ${subscriberPart.substring(3, 6)}${remaining.isNotEmpty ? ' $remaining' : ''}';
      }
    }

    // For any other format, just show as is
    return normalized;
  }

  /// Get display hint for a phone number as user types
  static String? getVisualHint(String input) {
    if (input.isEmpty) return null;

    // Only show hint for numeric input
    if (RegExp(r'^\d+$').hasMatch(input)) {
      // Don't show confusing hints for very short inputs except simple cases
      if (input.length < 3 && !input.startsWith('0')) {
        return null;
      }

      // For all cases, use the formatForDisplay method without padding zeros
      String formatted = formatForDisplay(input);

      // Only show hint if it's different from input (adds value)
      if (formatted != input) {
        return formatted;
      }
    }

    return null;
  }

  /// Validates a Tanzania phone number (in any input format)
  static bool isValidTanzaniaNumber(String phone) {
    // First normalize the number
    String normalized = normalizePhoneNumber(phone);

    // Then check if it matches the normalized pattern
    // note that 9 is for demo account 0987654321
    return RegExp(r'^255[679]\d{8}$').hasMatch(normalized);
  }
}

/// Input formatter that enforces Tanzania phone number format
///
/// Enhanced formatter for Tanzania phone numbers
/// This handles all possible input formats and standardizes them
class TzPhoneNumberFormatter extends TextInputFormatter {
  @override
  /// Custom formatter for Tanzania phone numbers with the following rules:
  ///
  /// - Numbers starting with 255: Must be exactly 12 digits (e.g., 255777777777)
  /// - Numbers starting with 0: Must be at least 10 digits (e.g., 0777777777)
  /// - Numbers starting with 7 or 6: Must be at least 9 digits, but should be prefixed with 0
  ///
  /// All other numbers are limited to 9 digits
  ///
  /// Note that this formatter allows deletion and backspace, but will not allow
  /// insertion of non-digit characters
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Allow backspace and deletion
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    // Remove any non-digit characters
    String digits = newValue.text.replaceAll(digitsOnlyRegex, '');

    /// Apply different formatting logic based on starting digits

    /// Handle numbers with Tanzania country code (255)
    ///
    /// Limit subscriber part to 9 digits (total 12 digits)
    if (digits.startsWith('255') && digits.length > 12) {
      digits = digits.substring(0, 12);
    }
    /// Handle numbers starting with 0 (local format)
    ///
    /// Limit to 10 digits for numbers starting with 0
    else if (digits.startsWith('0') && digits.length > 10) {
      digits = digits.substring(0, 10);
    }
    /// Handle numbers starting with 6 or 7 directly
    ///
    /// Limit to 9 digits for direct subscriber numbers
    else if (digits.startsWith(digitsStartsWithSixOrSeven) &&
        digits.length > 9) {
      digits = digits.substring(0, 9);
    }

    // Create a new TextEditingValue with the formatted text
    return TextEditingValue(
      text: digits,
      selection: TextSelection.collapsed(offset: digits.length),
    );
  }
}

/// Extension on TextEditingController to format phone numbers
extension TzPhoneControllerExtension on TextEditingController {
  /// Normalize phone number to Tanzania format (255xxxxxxxxx)
  String getNormalizedPhone() => TzPhoneUtils.normalizePhoneNumber(text);

  /// Check if the phone number is valid
  bool isValidPhone() => TzPhoneUtils.isValidTanzaniaNumber(text);
}
