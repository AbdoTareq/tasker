import 'package:dio/dio.dart';
import 'package:tasker/core/error/exceptions.dart';

import '../../export.dart';

const url = 'http://localhost:3000';

class Network {
  final Dio dio;
  final LocalDataSource box;
  Network({
    required this.dio,
    required this.box,
  });

  late Map<String, String?> headers;

  Future<Response> req(Future<Response> Function() requestType) async {
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language':
          (await box.containsKey(kLanguage) ? await box.read(kLanguage) : 'ar'),
    };
    try {
      final response = await requestType();
      if (response.statusCode! > 210 || response.statusCode! < 200) {
        // Logger().i(response.data);
        throw response.data;
      }
      // success
      return response;
    } on DioException catch (e) {
      // Logger().i(e.message);
      throw ServerException(message: e.message);
    } catch (e) {
      // Logger().i(e);
      throw ServerException(message: e.toString());
    }
  }

  String _getParamsFromBody(dynamic body) {
    String params = '';
    for (var i = 0; i < body?.keys.length; i++) {
      params += '${List.from(body?.keys)[i]}=${List.from(body?.values)[i]}';
      if (i != body!.keys.length - 1) {
        params += '&';
      }
    }
    return params;
  }

  Future<Response> post(String endPoint, dynamic body,
      {bool isParamData = false, String? baseUrl}) async {
    return req(() {
      return dio.post(
          (baseUrl ?? url) +
              endPoint +
              (isParamData ? _getParamsFromBody(body) : ''),
          data: isParamData ? {} : body,
          options: Options(headers: headers));
    });
  }

  Future<Response> put(
    String endPoint,
    dynamic body,
  ) {
    return req(() {
      return dio.put(url + endPoint,
          data: body, options: Options(headers: headers));
    });
  }

  Future<Response> delete(
    String endPoint,
    dynamic body,
  ) {
    return req(() {
      return dio.delete(url + endPoint,
          data: body, options: Options(headers: headers));
    });
  }

  Future<Response> get(String endPoint, dynamic body, {String? baseUrl}) {
    return req(() {
      return dio.get((baseUrl ?? url) + endPoint,
          options: Options(headers: headers));
    });
  }
}
