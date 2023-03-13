import 'package:cloud_gallery_flutter/src/cubit/cloud_cubit.dart';
import 'package:cloud_gallery_flutter/src/cubit/cloud_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  ImageUploadState createState() => ImageUploadState();
}

class ImageUploadState extends State<ImageUpload> {
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BlocBuilder<CloudCubit, CloudModel>(builder: (context, state) {
                return Container(
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
                    child: (state.imageUrl != null)
                        ? Image.network(state.imageUrl)
                        : Image.network('https://i.imgur.com/sUFH1Aq.png'));
              }),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<CloudCubit>().uploadImage();
                  },
                  child: const Text('upload'))
            ],
          ),
        ),
      ),
    );
  }
}
