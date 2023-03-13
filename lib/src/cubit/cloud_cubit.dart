import 'dart:io';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:cloud_gallery_flutter/src/cubit/cloud_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CloudCubit extends Cubit<CloudModel> {
  CloudCubit() : super(CloudModel(imageUrl: 'https://i.imgur.com/sUFH1Aq.png'));

  uploadImage() async {
    final firebaseStorage = FirebaseStorage.instance;
    final imagePicker = ImagePicker();
    PickedFile image;
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      image = (await imagePicker.getImage(source: ImageSource.gallery))!;
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot = await firebaseStorage
            .ref()
            .child('images/imageName${Random().nextInt(99)}')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        emit(CloudModel(imageUrl: downloadUrl));
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }
}
