import 'dart:convert';
import 'dart:io';
import 'package:finnoto_login/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../provider/user_preference.dart';

class MyDashBoard extends StatefulWidget {
  const MyDashBoard({
    super.key,
  });

  @override
  State<MyDashBoard> createState() => _MyDashBoardState();
}

class _MyDashBoardState extends State<MyDashBoard> {
  final _key = GlobalKey<ExpandableFabState>();
  XFile? pickedFile;
  List<String> uploadedImages = [];

  Future<void> _pickMedia() async {
    ImagePicker picker = ImagePicker();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Pick Media"),
        content: const Text("Choose a source"),
        actions: [
          TextButton(
            onPressed: () async {
              pickedFile = await picker.pickImage(source: ImageSource.camera);
              Navigator.pop(context);

              if (pickedFile == null) return;

              _uploadImage(pickedFile!.path);
            },
            child: const Text("Camera"),
          ),
          TextButton(
            onPressed: () async {
              pickedFile = await picker.pickImage(source: ImageSource.gallery);

              Navigator.of(context).pop();

              if (pickedFile == null) return;

              _uploadImage(pickedFile!.path);
            },
            child: const Text("Gallery"),
          ),
        ],
      ),
    );
  }

  Future<MediaType> http_parser_from_file(File file) async {
    List<int> bytes = await file.readAsBytes();
    String? mimeType = await lookupMimeType(file.path, headerBytes: bytes);
    return MediaType.parse(mimeType!);
  }

  Future<void> _uploadImage(String path) async {
    const snackBar = SnackBar(
      content: Text('Yay! Image uploaded to the server !!!!'),
    );
    if (path == '') return;

    String uploadUrl = 'https://eapi.finnoto.dev/api/b/document-upload/analyse';

    try {
      var file = File(path);
      MediaType mediaType = await http_parser_from_file(file);

      var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        path,
        filename: 'image.jpg',
        contentType: mediaType,
      ));

      request.headers['Authorization'] =
          'Bearer ${await UserPreferences.getAccessToken()}';

      var response = await request.send();

      ScaffoldMessenger.of(context).showSnackBar(snackBar);



      print(json.decode(await response.stream.bytesToString()));
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  void _logOut() async {
    await UserPreferences.setAccessToken('');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // If data is successfully fetched, build the UI
          return Scaffold(
              body: SafeArea(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      if (pickedFile == null)
                        const Text('No Image selected')
                      else
                        Center(
                          child: Image.file(File(pickedFile!.path)),
                        ),

                      SizedBox(height: 20), // Adjust the spacing as needed
                      Expanded(
                        child: ListView.builder(
                          itemCount: uploadedImages.length,
                          itemBuilder: (context, index) {
                            return Center(
                              child: Image.network(
                                uploadedImages[index],
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
              ),
              floatingActionButtonLocation: ExpandableFab.location,
              floatingActionButton: ExpandableFab(
                overlayStyle: ExpandableFabOverlayStyle(blur: 5),
                openButtonBuilder: RotateFloatingActionButtonBuilder(
                  child: const Icon(Icons.list),
                  fabSize: ExpandableFabSize.regular,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  shape: const CircleBorder(),
                ),
                closeButtonBuilder: FloatingActionButtonBuilder(
                  size: 60,
                  builder: (BuildContext context, void Function()? onPressed,
                      Animation<double> progress) {
                    return IconButton(
                      onPressed: onPressed,
                      icon: const Icon(
                        Icons.check_circle_outline,
                        size: 40,
                      ),
                    );
                  },
                ),
                children: [
                  FloatingActionButton.large(
                    heroTag: null,
                    child: const Icon(Icons.camera_enhance),
                    onPressed: () {
                      _pickMedia();
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      final state = _key.currentState;
                      if (state != null) {
                        debugPrint('isOpen:${state.isOpen}');
                        state.toggle();
                      }
                    },
                    icon: GestureDetector(
                      onTap: _logOut,
                      child: const Icon(
                        Icons.logout_sharp,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ));
        }
      },
    );
  }

  Future<void> _getUserData() async {
    // Retrieve user data from UserPreferences
    //String? userName = await UserPreferences.getUserName();
    //String? imageUrl = await UserPreferences.getImageUrl();
    String? accessToken = await UserPreferences.getAccessToken();

    if (accessToken == '') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }
}
