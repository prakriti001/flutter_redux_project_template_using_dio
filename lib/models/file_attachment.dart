import 'dart:io';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'file_attachment.g.dart';

abstract class FileAttachment
    implements Built<FileAttachment, FileAttachmentBuilder> {
  factory FileAttachment(
          [FileAttachmentBuilder updates(FileAttachmentBuilder builder)]) =
      _$FileAttachment;

  FileAttachment._();

  @BuiltValueField(wireName: 'attachment_url')
  String? get attachmentUrl;

  int? get id;

  @BuiltValueField(wireName: 'attachment_type')
  String? get attachmentType;

  @BuiltValueField(wireName: 'attachment_name')
  String? get attachmentName;

  File? get attachmentFile;

  @BuiltValueField(wireName: 'file_type')
  String? get fileType;

  @BuiltValueField(wireName: 'thumbnail_url')
  String? get thumbnailUrl;

  static Serializer<FileAttachment> get serializer =>
      _$fileAttachmentSerializer;
}
