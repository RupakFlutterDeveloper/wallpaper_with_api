import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaperapi_with/app_widget/wallpaper_bg_widget.dart';
import 'package:wallpaperapi_with/constant/app_constant.dart';
import 'package:wallpaperapi_with/data/remote/api_helper.dart';
import 'package:wallpaperapi_with/data/remote/repositary/wallpaper_repo.dart';
import 'package:wallpaperapi_with/screen/home/cubit/home_cubit.dart';
import 'package:wallpaperapi_with/screen/home/cubit/home_state.dart';
import 'package:wallpaperapi_with/screen/search/cubit/search_cubit.dart';
import 'package:wallpaperapi_with/screen/search/search_wall_page.dart';
import 'package:wallpaperapi_with/utils/utils_helper.dart';

//

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context).GetTrandingWallpaper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.primaryLightColor,
      body: ListView(
        children: [
          //1 part
          Container(
            height: 10,
          ),
          //2 part Search Cotroller start
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: TextField(
              controller: searchController,
              style: mtextstyle14(),
              decoration: InputDecoration(
                  hintText: "Find Wallpaper",
                  hintStyle: mtextstyle14(mColor: Colors.grey.shade400),
                  suffixIcon: InkWell(
                    onTap: () {
                      if (searchController.text.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) => SearchCubit(
                                          wallpaperRepo: WallpaperRepo(
                                              apiHelper: ApiHelper())),
                                      child: SearchWallPage(
                                        query: searchController.text,
                                      ),
                                    )));
                      }
                    },
                    child: Icon(
                      Icons.search_sharp,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0)),
                  fillColor: appColors.secondaryLightColor,
                  filled: true),
            ),
          ),
          //Search Controller End

          SizedBox(
            height: 10,
          ),
          //3 part Best Of Month start
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Text(
              "Best Of Month",
              style: mtextstyle16(mFontweight: FontWeight.bold),
            ),
          ),
          SizedBox(
              height: 200,
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (_, state) {
                  if (state is wallpaperLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is wallpaperErrorState) {
                    return Center(
                      child: Text("Error"),
                    );
                  } else if (state is wallpaperLoadedState) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.listphoto!.length,
                      itemBuilder: (_, index) {
                        var eachlist = state.listphoto![index];
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 11,
                              right: index == state.listphoto!.length - 1
                                  ? 11
                                  : 0),
                          child: WallpaperBgWidget(
                              imgUrl: eachlist.src!.portrait!),
                        );
                      },
                    );
                  }
                  return Container();
                },
              )),
          //Best of Month End

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Text(
              "Best Of CallerTone",
              style: mtextstyle16(mFontweight: FontWeight.bold),
            ),
          ),
          //caller Tune Color start
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AppConstant.mColor.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: 11,
                      right: index == AppConstant.mColor.length - 1 ? 11 : 0),
                  child: getColorToneWidget(AppConstant.mColor[index]),
                );
              },
            ),
          ),
          //Caller tune Color End
          SizedBox(
            height: 10,
          ),
          //List Image  Start

          Container(
            padding: EdgeInsets.only(left: 11, right: 11),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: AppConstant.mCategory.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 9 / 4,
                  crossAxisSpacing: 9,
                  mainAxisSpacing: 11,
                  crossAxisCount: 2),
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 11),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => SearchCubit(
                                  wallpaperRepo:
                                      WallpaperRepo(apiHelper: ApiHelper())),
                              child: SearchWallPage(
                                  query: AppConstant.mCategory[index]['title']),
                            ),
                          ));
                    },
                    child: (getCategoryWidget(
                        AppConstant.mCategory[index]['image'],
                        AppConstant.mCategory[index]['title'])),
                  ),
                );
              },
            ),
          )
          //lisyt Image End
        ],
      ),
    );
  }

  Widget getColorToneWidget(Color mColor) {
    return Container(
      width: 50,
      height: 50,
      decoration:
          BoxDecoration(color: mColor, borderRadius: BorderRadius.circular(11)),
    );
  }

  Widget getCategoryWidget(String imgurl, String title) {
    return Container(
      width: 200,
      height: 100,
      child: Center(
        child: Text(
          title,
          style: mtextstyle16(mColor: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21),
          image:
              DecorationImage(fit: BoxFit.cover, image: NetworkImage(imgurl))),
    );
  }
}
