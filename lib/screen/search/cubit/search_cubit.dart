import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaperapi_with/data/remote/repositary/wallpaper_repo.dart';
import 'package:wallpaperapi_with/model/wallpaper_model.dart';
import 'package:wallpaperapi_with/screen/search/cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  WallpaperRepo wallpaperRepo;
  SearchCubit({required this.wallpaperRepo}) : super(SearchInitialState());

  void getSearchWallpaper({required String query}) async {
    emit(SearchLoadingState());
    try {
      var wallpaper = await wallpaperRepo.getSearchWallpaper(mQuery: query);
      DataModel dataModel = DataModel.fromJson(wallpaper);

      emit(SearchLoadedState(
          photoList: dataModel.photos!,
          totalWallpaper: dataModel.totalResults!));
    } catch (e) {
      emit(SearchErrorState(errorMsg: "error is ${e.toString()}"));
    }
  }
}
