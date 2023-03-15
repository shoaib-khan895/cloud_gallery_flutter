import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class Repository{
  downloadImages() async {
    final storageRef = FirebaseStorage.instance.ref().child("images/");
    final listResult = await storageRef.listAll();
    List<String> downloadedImagesList = [];

    for (var item in listResult.items) {
      await item.getDownloadURL().then((value) {
        downloadedImagesList.add(value);
      });
    }
    return downloadedImagesList;
  }

  uploadImage() async {
    final firebaseStorage = FirebaseStorage.instance;
    final imagePicker = ImagePicker();
    PickedFile image;
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      image = (await imagePicker.getImage(source: ImageSource.gallery))!;
      var file = File(image.path);
        var snapshot = await firebaseStorage
            .ref()
            .child('images/${Random().nextInt(99)}')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

}