import 'package:dio/dio.dart';
import 'package:baiki2/model/list/model.dart';
import 'package:flutter/foundation.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://reqres.in/api/users?page=2';

  Future<ListModel> fetchListList() async {
    try {
      Response response = await _dio.get(_url);
      return ListModel.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return ListModel.withError("Data not found/ Connection Error");
    }
  }
}