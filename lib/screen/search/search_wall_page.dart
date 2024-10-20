import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaperapi_with/app_widget/wallpaper_bg_widget.dart';
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
  @override
  void initState() {
    BlocProvider.of<SearchCubit>(context).getSearchWallpaper(
      query: widget.query,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appColors.primaryLightColor,
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (_, state) {
            if (state is SearchLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SearchErrorState) {
              return Center(
                child: Text('Error ${state.errorMsg}'),
              );
            } else if (state is SearchLoadedState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      widget.query,
                      style: mtextstyle34(mFontweight: FontWeight.w900),
                    ),
                    Text(
                      "${state.totalWallpaper} Wallpaper",
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
                        itemCount: state.photoList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 3 / 4,
                            crossAxisSpacing: 9,
                            mainAxisSpacing: 11,
                            crossAxisCount: 2),
                        itemBuilder: (_, index) {
                          var eachphoto = state.photoList[index];
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: index == state.photoList.length - 1
                                    ? 8.0
                                    : 0),
                            child: WallpaperBgWidget(
                                imgUrl: eachphoto.src!.portrait!),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ));
  }
}
