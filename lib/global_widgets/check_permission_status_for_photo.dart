import 'dart:convert';
import 'dart:io';

import 'package:personal_pjt/core/theme/app_colors.dart';
import 'package:personal_pjt/core/theme/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

PermissionStatus? permissions;
PermissionStatus? permissions1;

class CheckPermissionForPhoto extends StatelessWidget {
  final String name;
  final IconData icon;
  final ValueSetter<File> imageFile;
  final ValueSetter<String> attachmentBase64;

  const CheckPermissionForPhoto(
      {Key? key,
      required this.name,
      required this.icon,
      required this.imageFile,
      required this.attachmentBase64})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (name == 'Camera') {
          if (await Permission.camera.isGranted) {
            _openImagePicker(ImageSource.camera, context);
          } else if (await Permission.camera.request().isGranted) {
            _openImagePicker(ImageSource.camera, context);
          } else {
            permissions = await Permission.camera.request();
            if (permissions!.isGranted) {
              _openImagePicker(ImageSource.camera, context);
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                        title: Text('Camera Permission'),
                        content: Text(
                            'This app needs camera access to take pictures for upload user profile photo'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('Deny'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          CupertinoDialogAction(
                            child: Text('Settings'),
                            onPressed: () => openAppSettings(),
                          ),
                        ],
                      ));
            }
          }
        } else if (name == 'Gallery') {
          if (await Permission.photos.isGranted) {
            _openImagePicker(ImageSource.gallery, context, fromGallery: true);
          } else if (await Permission.photos.request().isGranted) {
            _openImagePicker(ImageSource.gallery, context, fromGallery: true);
          } else {
            await Permission.photos.request();
            if (await Permission.photos.request().isGranted) {
              _openImagePicker(ImageSource.gallery, context, fromGallery: true);
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                        title: Text('Gallery Permission'),
                        content: Text(
                            'This app needs gallery access to select pictures for upload user profile photo'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('Deny'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          CupertinoDialogAction(
                            child: Text('Settings'),
                            onPressed: () => openAppSettings(),
                          ),
                        ],
                      ));
            }
          }
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 45.0,
            width: 45.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                    color: AppColors.textFieldTextColor, width: 1.0)),
            child: Icon(icon),
          ),
          const SizedBox(height: 10.0),
          Text(
            name,
            style: AppStyle.white15RegularTextStyle
                .copyWith(color: AppColors.textFieldTextColor),
          )
        ],
      ),
    );
  }

  Future _openImagePicker(ImageSource source, BuildContext context,
      {bool fromGallery = false}) async {
    try {
      final _file = await ImagePicker().pickImage(
          source: source, maxHeight: 400, maxWidth: 400, imageQuality: 80);
      if (_file != null) {
        List<int> imageBytes = await File(_file.path).readAsBytes();
        this.imageFile(File(_file.path));
        this.attachmentBase64(base64Encode(imageBytes));
        Navigator.pop(context);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
