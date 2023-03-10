import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
// class HomePage extends StatelessWidget {
//   HomePage({super.key});
//   final storage = FirebaseStorage.instance;
//   final storageRef = FirebaseStorage.instance.ref();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Cloud Storage'),
//         ),
//         body: Container(
//           alignment: Alignment.center,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.black, foregroundColor: Colors.white),
//             onPressed: () async {
//               final result = await FilePicker.platform.pickFiles();
//               if (result == null) return;
//               final pickedFile = result.files.first;
//               OpenAppFile.open(pickedFile.path!);
//               print(pickedFile.path);
//
//               final mountainsRef = storageRef.child(pickedFile.name);
//               final mountainImagesRef = storageRef.child(pickedFile.path!);
//               assert(mountainsRef.name == mountainImagesRef.name);
//               assert(mountainsRef.fullPath != mountainImagesRef.fullPath);
//
//               Directory appDocDir = await getApplicationDocumentsDirectory();
//               String filePath = '${appDocDir.absolute}/${pickedFile.name}';
//               File file = File(filePath);
//               await mountainsRef.putFile(file);
//               print('upload done');
//             },
//             child: const Text('pick'),
//           ),
//         ));
//   }
// }
//

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  ImageUploadState createState() => ImageUploadState();
}

class ImageUploadState extends State<ImageUpload> {
   String? imageUrl;

  int imgInt =Random().nextInt(99);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upload Image',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 10.0,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  border: Border.all(color: Colors.white),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(2, 2),
                      spreadRadius: 2,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: (imageUrl != null)
                    ? Image.network(imageUrl!)
                    : Image.network('https://i.imgur.com/sUFH1Aq.png')),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () {
                  uploadImage();
                },
                child: const Text('upload'))
          ],
        ),
      ),
    );
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

      if (image != null) {
        //Upload to Firebase
        var snapshot = await firebaseStorage
            .ref().child('images/imageName$imgInt').putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }
}


