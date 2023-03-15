import 'package:bloc/bloc.dart';
import '../model/model.dart';
import '../repository/repository.dart';

class UploadCubit extends Cubit<UploadModel> {
  UploadCubit()
      : super(UploadModel(imageUrl: 'https://i.imgur.com/sUFH1Aq.png'));
  Repository repository = Repository();

  uploadItems() async {
    String imageUrl = await repository.uploadImage();
    emit(UploadModel(imageUrl: imageUrl));
  }
}
