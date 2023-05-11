// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_upload_repository.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _FeedUploadRepository implements FeedUploadRepository {
  _FeedUploadRepository(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<dynamic>> uploadImage({
    required content,
    required amekaji,
    required casual,
    required guitar,
    required minimal,
    required sporty,
    required street,
    required latitude,
    required longitude,
    required files,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'accessToken': 'true',
      r'Content-Type': 'multipart/form-data',
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    _data.fields.add(MapEntry(
      'content',
      content,
    ));
    _data.fields.add(MapEntry(
      'hashtagDTO.amekaji',
      amekaji.toString(),
    ));
    _data.fields.add(MapEntry(
      'hashtagDTO.casual',
      casual.toString(),
    ));
    _data.fields.add(MapEntry(
      'hashtagDTO.guitar',
      guitar.toString(),
    ));
    _data.fields.add(MapEntry(
      'hashtagDTO.minimal',
      minimal.toString(),
    ));
    _data.fields.add(MapEntry(
      'hashtagDTO.sporty',
      sporty.toString(),
    ));
    _data.fields.add(MapEntry(
      'hashtagDTO.street',
      street.toString(),
    ));
    _data.fields.add(MapEntry(
      'latitude',
      latitude.toString(),
    ));
    _data.fields.add(MapEntry(
      'longitude',
      longitude.toString(),
    ));
    _data.files.addAll(files.map((i) => MapEntry('uploadFileDTO.files', i)));
    final _result =
        await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              '/post/regist',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
