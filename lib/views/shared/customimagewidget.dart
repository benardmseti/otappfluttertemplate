import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDynamicImage extends StatelessWidget {
  final String? path;
  final double? height;
  final String? encodedImageData;
  final double? width;
  final Color? color;
  final BoxFit fit;

  const CustomDynamicImage({
    super.key,
    this.path,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.contain,
    this.encodedImageData,
  });

  bool get isSvg => path?.toLowerCase().endsWith('.svg') ?? false;
  bool get isUrl => Uri.tryParse(path ?? '')?.hasAbsolutePath ?? false;

  @override
  Widget build(BuildContext context) {
    if (encodedImageData != null) {
      String base64Data = encodedImageData!;
      if (base64Data.contains(',')) {
        base64Data = base64Data.substring(base64Data.indexOf(',') + 1);
      }
      return Image.memory(
        base64Decode(base64Data),
        height: height,
        width: width,
        color: color,
        fit: fit,
        gaplessPlayback: true,
      );
    }
    if (isSvg) {
      return SvgPicture.asset(
        path!,
        height: height,
        width: width,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        fit: fit,
      );
    }
    if (isUrl) {
      return Image.network(
        path!,
        height: height,
        width: width,
        color: color,
        fit: fit,
      );
    }

    return Image.asset(
      path!,
      height: height,
      width: width,
      color: color,
      fit: fit,
    );
  }
}
