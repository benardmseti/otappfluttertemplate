import 'package:otappfluttertemplate/utils/constants/regex.dart';

/// Validates whether the provided [email] is in a correct email format.
///
/// Returns `true` if the [email] matches the standard email pattern,
/// otherwise returns `false`.
bool isValidEmail(String email) {
  return emailRegex.hasMatch(email);
}
