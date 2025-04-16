/// A file containing app wide reusable regex codes
///
/// Provides a centralized location for [RegExp] values
///
RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
RegExp phoneRegex = RegExp(r'^(?:\+?255|254|...)\d{8}$');
RegExp nameRegex = RegExp(r"^[A-Za-z0-9\s'‘’]+");
RegExp sanitizeFileNameRegex = RegExp(r'[^\w\d]');
RegExp digitsOnlyRegex = RegExp(r'\D');
RegExp digitsStartsWithSixOrSeven = RegExp(r'^[67]');
