import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Comprehensive utility class for handling Tanzania phone numbers
class TzPhoneUtils {
  /// Normalizes a phone number to standard Tanzania format (255xxxxxxxxx)
  static String normalizePhoneNumber(String phone) {
    // Remove any non-digit characters
    String digitsOnly = phone.replaceAll(RegExp(r'\D'), '');

    // If empty, return as is
    if (digitsOnly.isEmpty) return '';

    // Handle the case when user has entered only "255" (country code)
    if (digitsOnly == '255') return '255';

    // If it starts with a 0, replace with 255
    if (digitsOnly.startsWith('0')) {
      return '255${digitsOnly.substring(1)}';
    }

    // If it already starts with 255, check for issues
    if (digitsOnly.startsWith('255')) {
      // Get subscriber part (after 255)
      String subscriberPart = digitsOnly.substring(3);

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
    if (digitsOnly.startsWith('6') || digitsOnly.startsWith('7')) {
      // For incomplete or complete subscriber numbers, just return with country code
      // Don't pad with zeros for display purposes
      if (digitsOnly.length <= 9) {
        return '255$digitsOnly';
      }

      // If too long, truncate to 9 digits
      return '255${digitsOnly.substring(0, 9)}';
    }

    // Handle partial inputs (like "25")
    if (digitsOnly.length <= 3) {
      // Just return what they've typed so far - they're still typing
      return digitsOnly;
    }

    // For longer inputs that still don't start with expected patterns
    if (digitsOnly.length >= 4) {
      // For more complete numbers that could be subscriber parts
      return '255$digitsOnly';
    }

    // Fallback (should not reach here)
    return digitsOnly;
  }

  /// Format for display (e.g., +255 742 123 456)
  static String formatForDisplay(String phone) {
    String normalized = normalizePhoneNumber(phone);

    // Just country code or very short number
    if (normalized.length <= 3) {
      return normalized.startsWith('255') ? '+255' : normalized;
    }

    // Handle properly normalized numbers (255xxxxxxxxx)
    if (normalized.startsWith('255')) {
      String subscriberPart = normalized.substring(3);

      // Format based on available digits
      if (subscriberPart.length <= 3) {
        return '+255 $subscriberPart';
      } else if (subscriberPart.length <= 6) {
        return '+255 ${subscriberPart.substring(0, 3)} ${subscriberPart.substring(3)}';
      } else {
        String remaining =
            subscriberPart.length > 6 ? subscriberPart.substring(6) : '';
        return '+255 ${subscriberPart.substring(0, 3)} ${subscriberPart.substring(3, 6)}${remaining.isNotEmpty ? ' $remaining' : ''}';
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

/// Enhanced formatter for Tanzania phone numbers
/// This handles all possible input formats and standardizes them
class TzPhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Allow backspace and deletion
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    // Remove any non-digit characters
    String formattedValue = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Apply different formatting logic based on starting digits

    // Handle numbers with Tanzania country code (255)
    if (formattedValue.startsWith('255')) {
      // Limit subscriber part to 9 digits (total 12 digits)
      if (formattedValue.length > 12) {
        formattedValue = formattedValue.substring(0, 12);
      }
    }
    // Handle numbers starting with 0 (local format)
    else if (formattedValue.startsWith('0')) {
      // Limit to 10 digits for numbers starting with 0
      if (formattedValue.length > 10) {
        formattedValue = formattedValue.substring(0, 10);
      }
    }
    // Handle numbers starting with 6 or 7 directly
    else if (formattedValue.startsWith('6') || formattedValue.startsWith('7')) {
      // Limit to 9 digits for direct subscriber numbers
      if (formattedValue.length > 9) {
        formattedValue = formattedValue.substring(0, 9);
      }
    }

    // Create a new TextEditingValue with the formatted text
    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}

/// Extension on TextEditingController to format phone numbers
extension TzPhoneControllerExtension on TextEditingController {
  /// Normalize phone number to Tanzania format (255xxxxxxxxx)
  String getNormalizedPhone() {
    return TzPhoneUtils.normalizePhoneNumber(text);
  }

  /// Check if the phone number is valid
  bool isValidPhone() {
    return TzPhoneUtils.isValidTanzaniaNumber(text);
  }
}
