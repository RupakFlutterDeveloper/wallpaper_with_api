import 'package:flutter/material.dart';

class WallpaperBgWidget extends StatelessWidget {
  double mwidth;
  double mheight;
  String imgUrl;
  WallpaperBgWidget(
      {super.key, required this.imgUrl, this.mheight = 200, this.mwidth = 150});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mwidth,
      height: mheight,
      decoration: BoxDecoration(
          image:
              DecorationImage(fit: BoxFit.cover, image: NetworkImage(imgUrl)),
          borderRadius: BorderRadius.circular(21)),
    );
  }
}
