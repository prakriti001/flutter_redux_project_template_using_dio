import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart';
import 'package:personal_pjt/core/utils/utils.dart';
import 'package:personal_pjt/models/api_error.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:http/io_client.dart' as io_client;
import 'package:personal_pjt/models/models.dart';

dio.Dio dioClient = dio.Dio();
enum Method {
  GET,
  POST,
  PUT,
  DELETE,
  PATCH,
}

class ApiConfig {
  const ApiConfig({
    required this.scheme,
    required this.host,
    this.port,
    this.scope,
  }) : assert(scheme != null && host != null,
            'Scheme, host and port cannot be null');

  final String scheme;
  final String host;
  final int? port;
  final String? scope;

  @override
  String toString() {
    if (port == null) {
      return '$scheme://$host${scope ?? ''}';
    }
    return '$scheme://$host:$port${scope ?? ''}';
  }
}

class ApiResponse<T> extends dio.Response {
  ApiResponse.from(dio.Response response, this.responseKey, {this.fullType})
      : super(
          data:response.data,
          extra: response.extra,
          headers: response.headers,
          isRedirect: response.isRedirect,
          statusCode: response.statusCode,
    redirects: response.redirects,
    statusMessage: response.statusMessage,
    requestOptions:response.requestOptions
        ) {
    _data = _getData();
    _error = _getError();
//    _pagination = _getPagination();
  }

  final String? responseKey;

  final FullType? fullType;

  T? get resData => _data;

  T? _data;

  T? _getData() {
    if (!isSuccess || data == null) {
      return null;
    }
    dynamic decodedBody = data;
    if (responseKey != null) {
      decodedBody = decodedBody[responseKey];
    }
    return serializers.deserialize(
      decodedBody,
      specifiedType: fullType ?? FullType(T),
    ) as T;
  }

  // end

//   pagination block
//  bool get hasPagination => _pagination != null;
//
//  Pagination get pagination => _pagination;
//
//  Pagination _pagination;
//
//  Pagination _getPagination() {
//    if (!isSuccess || body == null) {
//      return null;
//    }
//
//    final dynamic decodedBody = json.decode(body);
//
//    if (decodedBody == null) {
//      return null;
//    }
//
//    if(decodedBody['pagination'] == null){
//      return null;
//    }
//
//    return serializers.deserialize(
//      decodedBody,
//      specifiedType: const FullType(Pagination),
//    );
//  }

  // end

  // error block
  dio.DioError? _error;

  dio.DioError get error => _error!;

  dio.DioError? _getError() {
    if (isSuccess) {
      return null;
    }
    const String errorKey = 'error';

    try {
      dio.DioError error=dio.DioError(requestOptions: requestOptions,response: data);
      dynamic decodedBody = error.response?.data[errorKey];
      return serializers.deserialize(
        decodedBody,
        specifiedType: const FullType(dio.DioError),
      ) as dio.DioError;
      return error.response?.data[errorKey];
    } on FormatException {
      // return ApiError((ApiErrorBuilder b) {
      //   return b
      //     ..status = 0
      //     ..message = ListBuilder<String>(<String>['Something went wrong']);
      // });
    }
  }

  // end

  bool get isSuccess => statusCode! >= 200 && statusCode! < 300;

  bool get isUnAuthorizedRequest => statusCode == 401;
}

//ApiClient used to make HTTP/HTTPS calls
class ApiClient extends io_client.IOClient {
  ApiClient({required this.config})
      : assert(config != null, 'Config cannot be null') {
    log.d(config.toString());
  }

  final Logger log = Logger(tag: 'ApiClient');

  final ApiConfig config;
  Map<String, String>? authHeaders;

  Map<String, String> get defaultHeaders =>
      <String, String>{'Content-Type': 'application/json'};

  Uri buildUrl({String? path, Map<String, dynamic>? queryParams}) {
    final Uri uri = Uri(
      scheme: config.scheme,
      host: config.host,
      port: config.port,
      queryParameters: queryParams,
      path: '${config.scope ?? ''}$path',
    );

    return uri;
  }

  Future<ApiResponse<R>> callJsonApi<R>({
    required Method method,
    required String path,
    List<String>? fileNames,
    List<String>? filePath,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool formDataRequest=false,
    Encoding? encoding,
    //Request data is wrapped in this key before making any request
    String? requestKey,
    //Deserializer uses this key to extract deserializable object from response
    String? responseKey,
    FullType? fullType,
  }) async {
    final Uri url = buildUrl(path: path, queryParams: queryParams);

    dio.Response response;

    Map<String, dynamic>? requestBody = body;

    if (requestKey != null) {
      requestBody = <String, dynamic>{'$requestKey': requestBody};
    }
    final String? encodedBody =
        requestBody != null ? json.encode(requestBody) : null;

    final Map<String, String> allHeaders = <String, String>{}
      ..addAll(defaultHeaders)
      ..addAll(authHeaders ?? <String, String>{})
      ..addAll(headers ?? <String, String>{});

    if (formDataRequest) {
      List<dio.MultipartFile> multiFiles=[];
      if(fileNames!=null && filePath!=null){
        for(int i=0;i<fileNames.length;i++){
          multiFiles.add(dio.MultipartFile.fromString(filePath[i], filename: fileNames[i]),);
        }
        requestBody!['files']= multiFiles;
      }
      var formData = dio.FormData.fromMap(requestBody!);
      switch (method) {
        case Method.POST:
          response = await dioClient.post(url.toString(), data: formData,
            queryParameters: queryParams,
            options: dio.Options(
              headers:allHeaders,
            ),);
          break;
        case Method.PUT:
          response = await dioClient.put(url.toString(), data: formData,
            queryParameters: queryParams,
            options: dio.Options(
              headers:allHeaders,
            ),);
          break;
        case Method.PATCH:
          response = await dioClient.patch(url.toString(), data: formData,
            queryParameters: queryParams,
            options: dio.Options(
              headers:allHeaders,
            ),);
          break;
        default:
          throw 'Method $method does not exist';
      }

    } else {
      switch (method) {
        case Method.GET:
          response = await dioClient.get(
            url.toString(),
            queryParameters: queryParams,
            options: dio.Options(
              headers:allHeaders,
            ),
          );
          break;
        case Method.POST:
          response = (await dioClient.post(
            url.toString(),
            queryParameters: queryParams,
            options: dio.Options(
              headers:allHeaders,
            ),
            data: encodedBody,
          ));
          break;
        case Method.PUT:
          response = await dioClient.put(
            url.toString(),
            queryParameters: queryParams,
            options: dio.Options(
              headers:allHeaders,
            ),
            data: encodedBody,
          );
          break;
        case Method.PATCH:
          response = await dioClient.patch(
            url.toString(),
            queryParameters: queryParams,
            options: dio.Options(
              headers:allHeaders,
            ),
            data: encodedBody,
          );
          break;
        case Method.DELETE:
          response = await dioClient.delete(
            url.toString(),
            queryParameters: queryParams,
            options: dio.Options(
              headers:allHeaders,
            ),
          );
          break;
        default:
          throw 'Method $method does not exist';
      }
    }
    log.d('''
    ____________________________________
   URL: ${response.requestOptions.path}
    Request-method: ${method.toString()}
    HEADERS: ${response.requestOptions.headers}
    REQUEST-BODY : ${requestBody?.toString()}
    RESPONSE : ${response.data}
    STATUS-CODE : ${response.statusCode}
    ____________________________________
    ''');
    return ApiResponse<R>.from(response, responseKey, fullType: fullType);
  }
}
