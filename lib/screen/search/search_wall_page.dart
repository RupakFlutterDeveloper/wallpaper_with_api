import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaperapi_with/app_widget/wallpaper_bg_widget.dart';
import 'package:wallpaperapi_with/model/wallpaper_model.dart';
import 'package:wallpaperapi_with/screen/details_wall_page.dart';
import 'package:wallpaperapi_with/screen/search/cubit/search_cubit.dart';
import 'package:wallpaperapi_with/screen/search/cubit/search_state.dart';
import 'package:wallpaperapi_with/utils/utils_helper.dart';

class SearchWallPage extends StatefulWidget {
  String query;
  String mColor;

  SearchWallPage({required this.query, this.mColor = ''});

  @override
  State<SearchWallPage> createState() => _SearchWallPageState();
}

class _SearchWallPageState extends State<SearchWallPage> {
  ScrollController? scrollcontroller;
  num totlaWallpaperCount = 0;
  int totlanNumberPages = 1;
  int pageCount = 1;
  List<PhotosModel> wallpaperList = [];

  @override
  void initState() {
    scrollcontroller = ScrollController();
    scrollcontroller!.addListener(
      () {
        if (scrollcontroller!.position.pixels ==
            scrollcontroller!.position.maxScrollExtent) {
          totlanNumberPages = totlaWallpaperCount ~/ 15 + 1;
          if (totlanNumberPages > pageCount) {
            pageCount++;
            BlocProvider.of<SearchCubit>(context).getSearchWallpaper(
                query: widget.query, color: widget.mColor, page: pageCount);
          } else {
            print("You have reach count");
          }

          print("end of List");
        }
      },
    );
    BlocProvider.of<SearchCubit>(context)
        .getSearchWallpaper(query: widget.query, color: widget.mColor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appColors.primaryLightColor,
        body: BlocListener<SearchCubit, SearchState>(
          listener: (_, state) {
            if (state is SearchLoadingState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      pageCount != 1 ? "Next Page Loading..." : "Loading")));
            } else if (state is SearchErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMsg)));
            } else if (state is SearchLoadedState) {
              totlaWallpaperCount = state.totalWallpaper;
              wallpaperList.addAll(state.photoList);
              setState(() {});
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              controller: scrollcontroller,
              children: [
                SizedBox(
                  height: 24,
                ),
                Text(
                  widget.query,
                  style: mtextstyle34(mFontweight: FontWeight.w900),
                ),
                Text(
                  "${totlaWallpaperCount} Wallpaper",
                  style: mtextstyle16(),
                ),
                SizedBox(
                  height: 21,
                ),
                Container(
                  //padding: EdgeInsets.only(left: 11, right: 11),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: wallpaperList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 3 / 4,
                        crossAxisSpacing: 9,
                        mainAxisSpacing: 11,
                        crossAxisCount: 2),
                    itemBuilder: (_, index) {
                      var eachphoto = wallpaperList[index];
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom:
                                index == wallpaperList.length - 1 ? 8.0 : 0),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsWallPage(
                                        imgModel: eachphoto.src!),
                                  ));
                            },
                            child: WallpaperBgWidget(
                                imgUrl: eachphoto.src!.portrait!)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
