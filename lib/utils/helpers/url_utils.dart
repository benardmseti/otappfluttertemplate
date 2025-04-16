import 'package:url_launcher/url_launcher.dart';

/// Launches a URL in the default browser or app.
///
/// If the [url] cannot be launched, throws a string describing the error.
///
/// This uses the [url_launcher] package under the hood.
Future<void> launchURL(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}
