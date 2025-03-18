import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class LocalImageDisplay extends StatefulWidget {
  @override
  _LocalImageDisplayState createState() => _LocalImageDisplayState();
}

class _LocalImageDisplayState extends State<LocalImageDisplay> {
  late Future<File> imageFile;

  @override
  void initState() {
    super.initState();
    // Initialize the future here
    imageFile = loadImageFile();
  }

  Future<File> loadImageFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/logo.png';
    File file = File(filePath);

    // Ensure the file exists before returning
    if (!await file.exists()) {
      print("Logo file does not exist.");
      throw Exception('File not found!');
    }
    print('File exists');
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Image Display'),
      ),
      body: FutureBuilder<File>(
        future: imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return Center(
              child: Image.file(snapshot.data!),
            );
          } else if (snapshot.error != null) {
            // If something went wrong
            return Center(
              child: Text("Error loading the image"),
            );
          } else {
            // While loading
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
