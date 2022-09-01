import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart_helper.dart';
PermissionStatus? permissions;
void checkForGalleryPermission(BuildContext context, bool isMultipleImage,
    ValueSetter<List<File>> imageFile) async {
  Future _openFilePicker(BuildContext context) async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(allowMultiple: isMultipleImage,allowedExtensions:
    ['tiff', 'jpg', 'png', 'doc', 'docx' , 'pdf','jpeg'] ,type: FileType.custom);
    if (!DartHelper.isNullOrEmptyLists(result!.files)) {
      imageFile(result.paths.map((path) => File(path!)).toList());
    }
  }

  if (await Permission.photos.isGranted) {
    _openFilePicker(context);
  } else if (await Permission.photos.request().isGranted) {
    _openFilePicker(context);
  } else {
    await Permission.photos.request();
    if (await Permission.photos.request().isGranted) {
      _openFilePicker(context);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('Gallery Permission'),
              content: const Text(
                  'This app needs gallery access to select pictures for upload user profile photo'),
              actions: <Widget>[
                CupertinoDialogAction(
                    child: const Text('Deny'),
                    onPressed: () => Navigator.of(context).pop()),
                CupertinoDialogAction(
                    child: const Text('Settings'),
                    onPressed: () => openAppSettings())
              ]));
    }
  }
}
