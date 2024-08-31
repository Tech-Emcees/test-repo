import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:sih_1/button.dart';
import 'package:sih_1/service.dart';
import 'package:video_player/video_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

final _formKey = GlobalKey<FormState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String type = '';
  late FlickManager flickManager;

  final TextEditingController _usernameController = TextEditingController();

  dynamic model;
  dynamic imageUrl;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse('')),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Button(
                    onPressed: () async {
                      final XFile? img =
                          await _picker.pickImage(source: ImageSource.gallery);

                      final file = File(img!.path);

                      final String extension = path.extension(file.path);

                      Reference firebaseStorageRef =
                          FirebaseStorage.instance.ref().child('img$extension');

                      UploadTask uploadTask = firebaseStorageRef.putFile(file);

                      await uploadTask;

                      String downloadUrl =
                          await firebaseStorageRef.getDownloadURL();

                      final id = await imagePostApiRequest(downloadUrl);

                      print(id);
                      model = await imageGetApiRequest(id);

                      print(model['thumbnail_url']);

                      setState(() {
                        imageUrl = model['thumbnail_url'];
                        type = 'image';
                      });
                    },
                    icon: Icons.add_a_photo_outlined,
                  ),

//------------------------------------------------------------------------------

                  SizedBox(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: Form(
                        child: TextFormField(
                          key: _formKey,
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter a prompt',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

//------------------------------------------------------------------------------

                  Button(
                    onPressed: () async {
                      final id =
                          await textPostApiRequest(_usernameController.text);

                      print(id);
                      model = await textGetApiRequest(id);

                      print(model['thumbnail_url']);
                      print(model['video_url']);

                      setState(() {
                        type = 'video';

                        flickManager = FlickManager(
                          videoPlayerController:
                              VideoPlayerController.networkUrl(
                            Uri.parse(model['video_url']),
                          )..setLooping(true),
                          onVideoEnd: () {
                            flickManager.flickControlManager!.replay();
                          },
                        );
                      });
                    },
                    icon: Icons.send_outlined,
                  ),
                ],
              ),

//------------------------------------------------------------------------------

              Container(
                color: Colors.transparent,
                height: 200,
              ),

//------------------------------------------------------------------------------

              if (type == 'video')
                SizedBox(
                  height: 410,
                  width: 410,
                  child: FlickVideoPlayer(flickManager: flickManager),
                )
              else if (type == 'image')
                Image.network(model['thumbnail_url'])
            ],
          ),
        ),
      ),
    );
  }
}
