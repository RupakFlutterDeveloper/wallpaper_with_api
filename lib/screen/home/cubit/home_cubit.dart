import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaperapi_with/data/remote/repositary/wallpaper_repo.dart';
import 'package:wallpaperapi_with/model/wallpaper_model.dart';
import 'package:wallpaperapi_with/screen/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  WallpaperRepo wallpaperRepo;
  HomeCubit({required this.wallpaperRepo}) : super(wallpaperInitialState());

  void GetTrandingWallpaper() async {
    emit(wallpaperLoadingState());
    try {
      var data = await wallpaperRepo.GetTrandingWallpaper();
      var WallpaperModel = DataModel.fromJson(data);
      emit(wallpaperLoadedState(listphoto: WallpaperModel.photos));
    } catch (e) {
      emit(wallpaperErrorState(error: "could not found ${e.toString()}"));
    }
  }
}
