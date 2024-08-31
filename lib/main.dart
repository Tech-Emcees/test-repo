import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:sih_1/service.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

final _formKey = GlobalKey<FormState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool video = false;
  late FlickManager flickManager;

  final TextEditingController _usernameController = TextEditingController();

  dynamic model;

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
                  SizedBox(
                    width: 320,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 5),
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
                  SizedBox(
                    width: 80,
                    child: IconButton(
                      onPressed: () async {
                        final id =
                            await postApiRequest(_usernameController.text);
                        print(id);
                        model = await getApiRequest(id);

                        print(model['thumbnail_url']);
                        print(model['video_url']);

                        setState(() {
                          video = true;

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
                      icon: const Icon(Icons.send_outlined),
                    ),
                  ),
                ],
              ),

//------------------------------------------------------------------------------

              Container(
                color: Colors.transparent,
                height: 200,
              ),

//------------------------------------------------------------------------------

              if (video)
                SizedBox(
                  height: 410,
                  width: 410,
                  child: FlickVideoPlayer(flickManager: flickManager),
                )
            ],
          ),
        ),
      ),
    );
  }
}
