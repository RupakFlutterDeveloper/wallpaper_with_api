import 'package:wallpaperapi_with/model/wallpaper_model.dart';

abstract class HomeState {}

class wallpaperInitialState extends HomeState {}

class wallpaperLoadingState extends HomeState {}

class wallpaperLoadedState extends HomeState {
  List<PhotosModel>? listphoto;
  wallpaperLoadedState({this.listphoto});
}

class wallpaperErrorState extends HomeState {
  final String error;
  wallpaperErrorState({required this.error});
}
