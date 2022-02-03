import 'dart:convert';

import 'package:built_value/serializer.dart';
import 'package:meta/meta.dart';
import 'package:personal_pjt/data/api/api_client.dart';
import 'package:personal_pjt/models/serializers.dart';

abstract class ApiService {
  const ApiService({required this.client}) : assert(client != null);

  final ApiClient? client;

  Map<String, String> get defaultHeaders => client!.defaultHeaders;

  Map<String, String> get authHeaders => client!.authHeaders!;

  Map<String, String> getAllHeaders({Map<String, String>? headers}) {
    return <String, String>{}
      ..addAll(client!.defaultHeaders)
      ..addAll(client!.authHeaders ?? <String, String>{})
      ..addAll(headers ?? <String, String>{});
  }

  // String buildUrl({String? path, Map<String, dynamic>? queryParams}) =>
  //     client!.buildUrl(path: path!, queryParams: queryParams!);

  Map<String, dynamic> buildBodyFrom<T>(
    T data, {
    List<String>? keysToRemove,
    Map<String, dynamic>? dataToAdd,
    String? withRootKey,
  }) {
    final Map<String, dynamic> body = serialize(data) as Map<String, dynamic>;
    keysToRemove?.forEach(body.remove);
    body.addAll(dataToAdd ?? <String, dynamic>{});
    if (withRootKey != null) {
      final Map<String, dynamic> withRoot = <String, dynamic>{};
      withRoot[withRootKey] = body;
      return withRoot;
    }
    return body;
  }

  String encode(dynamic data) {
    return json.encode(data);
  }

  dynamic decode(String data) {
    return json.decode(data);
  }

  Object? serializeQuery<T>(T query, {FullType? fullType}) {
    if (query == null) {
      return null;
    }

    return serialize<T>(query, fullType: fullType);
  }

  Object? serialize<T>(T data, {FullType? fullType}) {
    return serializers.serialize(
      data,
      specifiedType: fullType ?? FullType(T),
    );
  }

  Object? deserialize<T>(Object data, {FullType? fullType}) {
    return serializers.deserialize(data);
  }
}
