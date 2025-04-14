import 'dart:convert';
import 'package:flutter/material.dart';

import '../views/shared/customimagewidget.dart';

class ImageUtils {
  /// Creates an appropriate image widget based on the image path
  /// Handles base64 encoded images, asset paths, and fallbacks
  static Widget getImageWidget({
    required String imagePath,
    required double height,
    required double width,
    BoxFit fit = BoxFit.cover,
    String fallbackAsset = 'assets/thor.png',
  }) {
    // Check if imagePath is a base64 string
    if (imagePath.startsWith('data:image') ||
        imagePath.contains(';base64,') ||
        RegExp(r'^[A-Za-z0-9+/=]+$').hasMatch(imagePath)) {
      try {
        String base64Data = imagePath;
        if (base64Data.contains(',')) {
          base64Data = base64Data.substring(base64Data.indexOf(',') + 1);
        }
        return Image.memory(
          base64Decode(base64Data),
          height: height,
          width: width,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return CustomDynamicImage(
              path: fallbackAsset,
              height: height,
              width: width,
              fit: fit,
            );
          },
        );
      } catch (e) {
        // Fall back to default image on error
        return CustomDynamicImage(
          path: fallbackAsset,
          height: height,
          width: width,
          fit: fit,
        );
      }
    } else {
      // For asset paths or other formats
      return CustomDynamicImage(
        path: imagePath.startsWith('assets/') ? imagePath : fallbackAsset,
        height: height,
        width: width,
        fit: fit,
      );
    }
  }
}
