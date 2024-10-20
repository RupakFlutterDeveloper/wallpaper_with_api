import 'package:wallpaperapi_with/model/wallpaper_model.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  List<PhotosModel> photoList;
  num totalWallpaper;
  SearchLoadedState({required this.photoList, required this.totalWallpaper});
}

class SearchErrorState extends SearchState {
  String errorMsg;
  SearchErrorState({required this.errorMsg});
}
