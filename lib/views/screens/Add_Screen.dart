import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/views/Confirmation_Screen.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ConfirmationScreen(
          videoFile: File(video.path),
          videoPath: video.path,
        ),
      ));
    }
  }

  showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.gallery, context),
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Gallery', style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.camera, context),
                  child: Row(
                    children: [
                      Icon(Icons.camera),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Camera', style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Row(
                    children: [
                      Icon(Icons.cancel),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Cancel', style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () => showOptionsDialog(context),
        child: Container(
          alignment: Alignment.center,
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(2),
          ),
          child: const Text(
            'Add Video',
            style: TextStyle(
                color: Colors.white, fontSize: 19, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
