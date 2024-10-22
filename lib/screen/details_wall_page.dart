import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallpaperapi_with/model/wallpaper_model.dart';
import 'package:wallpaperapi_with/utils/utils_helper.dart';

class DetailsWallPage extends StatelessWidget {
  SrcModel imgModel;
  DetailsWallPage({required this.imgModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              imgModel.portrait!,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getActBtn(
                        onPressed: () {},
                        title: "Info",
                        icon: Icons.info_outline),
                    SizedBox(
                      width: 21,
                    ),
                    getActBtn(
                        onPressed: saveWallpaper,
                        title: "Save",
                        icon: Icons.download),
                    SizedBox(
                      width: 21,
                    ),
                    getActBtn(
                        onPressed: applywallpaper,
                        title: "Apply",
                        icon: Icons.format_paint,
                        bgColor: Colors.blueAccent),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getActBtn(
      {required VoidCallback onPressed,
      required String title,
      Color? bgColor,
      required IconData icon}) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(11)),
              color: bgColor != null
                  ? Colors.blueAccent
                  : Colors.white.withOpacity(0.4)),
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          title,
          style: mtextstyle12(mColor: Colors.white),
        )
      ],
    );
  }

  void saveWallpaper() {}
  void applywallpaper() {}
}
