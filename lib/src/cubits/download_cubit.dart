import 'package:bloc/bloc.dart';
import 'package:cloud_gallery_flutter/src/repository/repository.dart';
import '../model/model.dart';

class DownloadCubit extends Cubit<DownloadModel> {
  DownloadCubit() : super(DownloadModel(imagesUrlsList: []));
  Repository repository = Repository();

  downloadItems() async {
  List<String> list = await repository.downloadImages();
     emit(DownloadModel(imagesUrlsList: list));
  }


}
