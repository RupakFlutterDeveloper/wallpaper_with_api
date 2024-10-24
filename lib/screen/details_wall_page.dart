import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Add this for downloading image
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart'; // Add this to get file path
import 'package:wallpaper/wallpaper.dart';
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
              fit: BoxFit.contain,
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
                    SizedBox(width: 21),
                    getActBtn(
                        onPressed: () {
                          saveWallpaper(context);
                        },
                        title: "Save",
                        icon: Icons.download),
                    SizedBox(width: 21),
                    getActBtn(
                        onPressed: () {
                          applywallpaper(context);
                        },
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
        InkWell(
          onTap: onPressed,
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(11)),
                color:
                    bgColor ?? Colors.white.withOpacity(0.4)), // Fixed bgColor
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
        SizedBox(height: 2),
        Text(
          title,
          style: mtextstyle12(mColor: Colors.white),
        ),
      ],
    );
  }

  // Save wallpaper function
  void saveWallpaper(BuildContext context) async {
    try {
      // Step 1: Download the image
      var response = await http.get(Uri.parse(imgModel.portrait!));
      Uint8List bytes = response.bodyBytes;

      // Step 2: Get the directory to save the image
      final directory = await getApplicationDocumentsDirectory();
      String fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
      File imgFile = File('${directory.path}/$fileName');

      // Step 3: Write the image to file
      await imgFile.writeAsBytes(bytes);

      // Step 4: Save image to gallery
      final result = await ImageGallerySaver.saveFile(imgFile.path);

      if (result['isSuccess']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Wallpaper saved to gallery")),
        );
        openGallery();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving wallpaper: $e")),
      );
    }
  }

  void openGallery() async {
    const galleryUrl =
        'content://media/internal/images/media'; // URI for the gallery

    // if (await canLaunch(galleryUrl)) {
    //   await launch(galleryUrl);
    // } else {
    //   print("Could not open the gallery");
    // }
  }

  // Apply wallpaper function
  void applywallpaper(BuildContext context) {
    Wallpaper.imageDownloadProgress(imgModel.portrait!).listen((event) {
      print(event);
    }, onDone: () {
      Wallpaper.homeScreen(
              options: RequestSizeOptions.resizeFit,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width)
          .then(
        (value) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Wallpaper set on HomeScreen")));
        },
      );
    }, onError: (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Wallpaper $e")));
    });
  }
}
