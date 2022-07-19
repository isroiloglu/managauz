import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CustomCameraDialog extends StatelessWidget {
  final int imageQuality; //0-100
  final int compressQuality; //0-100
  final Function(File imageFile, int type)? callback;

  const CustomCameraDialog._({
    Key? key,
    this.callback,
    this.imageQuality = 50,
    this.compressQuality = 50,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context, {
    Function(File imageFile, int type)? callback,
    int imageQuality = 50,
    int compressQuality = 50,
  }) async {
    FocusScope.of(context).unfocus();
    await showDialog(
      context: context,
      builder: (_) => CustomCameraDialog._(
        callback: callback,
        imageQuality: imageQuality,
        compressQuality: compressQuality,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.6;
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFCECECE)),
                const SizedBox(height: 12),
                _item(
                  context: context,
                  iconData: CupertinoIcons.camera,
                  text: "Полка",
                  source: ImageSource.camera,
                  index: 0,
                ),
                const SizedBox(height: 12),
                _item(
                  index: 1,
                  context: context,
                  iconData: CupertinoIcons.camera,
                  text: "Фасад",
                  source: ImageSource.camera,
                ),
                const SizedBox(height: 12),
                _item(
                  index: 2,
                  context: context,
                  iconData: CupertinoIcons.camera,
                  text: "ФТО",
                  source: ImageSource.camera,
                ),
                const SizedBox(height: 12),
                _item(
                  index: 3,
                  context: context,
                  iconData: CupertinoIcons.camera,
                  text: "Конкурент товар",
                  source: ImageSource.camera,
                ),
                const SizedBox(height: 12),
                const Divider(color: Color(0xFFCECECE)),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _item({
    required BuildContext context,
    required IconData iconData,
    required String text,
    required int index,
    required ImageSource source,
  }) {
    final picker = ImagePicker();
    final cropper = ImageCropper();
    return GestureDetector(
      onTap: () async {
        final file = await picker.pickImage(
          source: source,
          imageQuality: imageQuality,
        );
        if (file != null) {
          final cropFile = await ImageCropper().cropImage(
            sourcePath: file.path,
            aspectRatio: const CropAspectRatio(
              ratioX: 1,
              ratioY: 1,
            ),
            compressQuality: compressQuality,
          );
          if (cropFile != null) {
            if (callback != null) callback!(cropFile, index);
            Navigator.pop(context);
          }
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          const SizedBox(width: 12),
          Icon(iconData, color: Colors.blue, size: 28),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(width: 18),
        ],
      ),
    );
  }
}
