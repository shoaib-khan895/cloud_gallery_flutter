import 'package:cloud_gallery_flutter/src/cubits/download_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/model.dart';
import '../cubits/upload_cubit.dart';
import 'download_page.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  UploadPageState createState() => UploadPageState();
}

class UploadPageState extends State<UploadPage> {
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
              BlocBuilder<UploadCubit, UploadModel>(builder: (context, state) {
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
                        : Image.asset('assets/img.png'));
              }),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<UploadCubit>().uploadItems();
                  },
                  child: const Text('upload')),
              ElevatedButton(
                  onPressed: () {
                    context.read<DownloadCubit>().downloadItems();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                                value: BlocProvider.of<DownloadCubit>(context),
                                child: const DownloadPage(),
                              )),
                    );
                  },
                  child: const Text('show Files'))
            ],
          ),
        ),
      ),
    );
  }
}
