import 'package:wallpaperapi_with/data/remote/api_helper.dart';
import 'package:wallpaperapi_with/data/remote/urls.dart';

class WallpaperRepo {
  ApiHelper apiHelper;
  WallpaperRepo({required this.apiHelper});

  //Tranding Wallpaper
  Future<dynamic> GetTrandingWallpaper() async {
    try {
      var actWall = await apiHelper.getApi(AppUrls.TRANDING_WALL_URLS);
      return actWall;
    } catch (e) {
      rethrow;
    }
  }

//8144919185
  Future<dynamic> getSearchWallpaper({
    required String mQuery,
  }) async {
    try {
      var searchwall =
          await apiHelper.getApi("${AppUrls.SEARCH_WALL_URLS}$mQuery");
      return searchwall;
    } catch (e) {
      rethrow;
    }
  }
}
