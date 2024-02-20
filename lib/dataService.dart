import 'package:dio/dio.dart';

class DataService {
  static final Dio _dio = Dio();

  static Future<Map<String, dynamic>> getTestLocal() async {
    try {

//Replace this to your own url server
      Response response = await _dio.get('https://my-json-server.typicode.com/OmarHasan1996/json_server/body');
      return response.data;
    } catch (e) {
      throw Exception('Error getting data: $e');
    }
  }

}