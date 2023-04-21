import 'package:bloc_app/core/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppCachedImage extends StatelessWidget {
  const AppCachedImage({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      filterQuality: FilterQuality.low,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
            colorFilter:
                const ColorFilter.mode(Colors.white, BlendMode.colorBurn),
          ),
        ),
      ),
      fit: BoxFit.cover,
      imageUrl: imageUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
        margin: EdgeInsets.symmetric(
          vertical: Get.height / 6,
          horizontal: Get.width / 6,
        ),
        child: CircularProgressIndicator(
          value: downloadProgress.progress,
          color: AppColors.myRed,
          backgroundColor: AppColors.myWhite,
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
