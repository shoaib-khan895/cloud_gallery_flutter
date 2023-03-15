
import 'package:cloud_gallery_flutter/src/cubits/download_cubit.dart';
import 'package:cloud_gallery_flutter/src/screens/upload_page.dart';
import 'package:cloud_gallery_flutter/src/cubits/upload_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print('Completed');
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud Storage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => UploadCubit(),
          ),
          BlocProvider(
            create: (_) => DownloadCubit(),
          ),
        ],
        child: const UploadPage(),
      ),
    );
  }
}
